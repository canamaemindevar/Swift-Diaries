//
//  DetailsView.swift
//  favoriteBook
//
//  Created by Emincan on 11.01.2023.
//

import SwiftUI

struct DetailsView: View {
    
    var choosenFav: FavElements
    
    var body: some View {
        
        VStack{
            Image(choosenFav.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                
            Text(choosenFav.name)
        }
        
        
    }
}

struct DetailsView_Previews: PreviewProvider {
    static var previews: some View {
        DetailsView(choosenFav: metallice)
    }
}
