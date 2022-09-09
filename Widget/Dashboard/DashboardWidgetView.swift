//
//  DashboardWidgetView.swift
//  Widget
//
//  Created by Marino Faggiana on 20/08/22.
//  Copyright © 2022 Marino Faggiana. All rights reserved.
//
//  Author Marino Faggiana <marino.faggiana@nextcloud.com>
//
//  This program is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  This program is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.
//

import SwiftUI
import WidgetKit

struct DashboardWidgetView: View {

    var entry: DashboardDataEntry
    
    var body: some View {
        
        GeometryReader { geo in

            ZStack(alignment: .topLeading) {

                HStack() {
                    
                    Image(uiImage: entry.titleImage)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .clipped()
                        .cornerRadius(5)
                    
                    Text(entry.title)
                        .font(.system(size: 15))
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                        .textCase(.uppercase)
                        .lineLimit(1)
                }
                .frame(width: geo.size.width - 20)
                .padding([.top, .leading, .trailing], 10)
                
                VStack(alignment: .leading) {
                    
                    VStack(spacing: 0) {
                        
                        let datasCount = CGFloat(entry.datas.count)
                        let heightFrame = (geo.size.height - 80) / datasCount
                        let addSizeIcon = heightFrame / datasCount
                        let spacing = (addSizeIcon - datasCount) / 2
                        
                        ForEach(entry.datas, id: \.id) { element in
                            
                            Link(destination: element.link) {
                                
                                HStack {
                                    
                                    let subTitleColor = Color(white: 0.5)
                                    let imageSize:CGFloat = 30
                                    
                                    Image(uiImage: element.icon)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: imageSize+addSizeIcon, height: imageSize+addSizeIcon)
                                        .clipped()
                                        .cornerRadius(5)

                                    VStack(alignment: .leading, spacing: spacing) {

                                        Text(element.title)
                                            .font(.system(size: 12))
                                            .fontWeight(.regular)

                                        Text(element.subTitle)
                                            .font(.system(size: CGFloat(10)))
                                            .foregroundColor(subTitleColor)
                                    }
                                    Spacer()
                                }
                                .padding(.leading, 10)
                                .frame(height: heightFrame)
                            }
                            Divider()
                                .padding(.leading, 48 + addSizeIcon)
                        }
                    }
                }
                .padding(.top, 40)
                .redacted(reason: entry.isPlaceholder ? .placeholder : [])

                /*
                HStack(spacing: 0) {

                    let sizeButton: CGFloat = 40
                    let placeholderColor = Color(white: 0.8)
                    let brandColor = Color(NCBrandColor.shared.brand)
                    let brandTextColor = Color(NCBrandColor.shared.brandText)
                    
                    Link(destination: entry.isPlaceholder ? NCGlobal.shared.widgetActionNoAction : NCGlobal.shared.widgetActionVoiceMemo, label: {
                        Image("microphone")
                            .resizable()
                            .renderingMode(.template)
                            .foregroundColor(entry.isPlaceholder ? placeholderColor : brandTextColor)
                            .padding(10)
                            .background(entry.isPlaceholder ? placeholderColor : brandColor)
                            .clipShape(Circle())
                            .scaledToFit()
                            .frame(width: geo.size.width, height: sizeButton)
                    })
                }
                .frame(width: geo.size.width, height: geo.size.height - 25, alignment: .bottomTrailing)
                .redacted(reason: entry.isPlaceholder ? .placeholder : [])
                */
                
                HStack {

                    let placeholderColor = Color(white: 0.2)
                    let brandColor = Color(NCBrandColor.shared.brand)

                    Image(systemName: entry.footerImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 15, height: 15)
                        .foregroundColor(entry.isPlaceholder ? placeholderColor : brandColor)

                    Text(entry.footerText)
                        .font(.caption2)
                        .padding(.trailing, 13.0)
                }
                .frame(maxWidth: geo.size.width - 5, maxHeight: geo.size.height - 2, alignment: .bottomTrailing)
            }
        }
    }
}

struct DashboardWidget_Previews: PreviewProvider {
    static var previews: some View {
        let datas = Array(dashboardDatasTest[0...dashboaardItems - 1])
        let title = "Dashboard"
        let titleImage = UIImage(named: "nextcloud")!
        let entry = DashboardDataEntry(date: Date(), datas: datas, isPlaceholder: false, titleImage: titleImage, title: title, footerImage: "checkmark.icloud", footerText: "Nextcloud widget")
        DashboardWidgetView(entry: entry).previewContext(WidgetPreviewContext(family: .systemLarge))
    }
}
