Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751904AbeEKSvn (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 14:51:43 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:27106 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751705AbeEKSvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 14:51:42 -0400
Subject: Re: [PATCH v3] net: phy: DP83TC811: Introduce support for the
 DP83TC811 phy
To: Andrew Lunn <andrew@lunn.ch>
CC: <f.fainelli@gmail.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180511180819.5036-1-dmurphy@ti.com>
 <20180511183006.GB12738@lunn.ch>
From: Dan Murphy <dmurphy@ti.com>
Message-ID: <56ca63ce-d609-5bb7-f38c-17d875496bd5@ti.com>
Date: Fri, 11 May 2018 13:51:28 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511183006.GB12738@lunn.ch>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew

On 05/11/2018 01:30 PM, Andrew Lunn wrote:
> On Fri, May 11, 2018 at 01:08:19PM -0500, Dan Murphy wrote:
>> Add support for the DP83811 phy.
>>
>> The DP83811 supports both rgmii and sgmii interfaces.
>> There are 2 part numbers for this the DP83TC811R does not
>> reliably support the SGMII interface but the DP83TC811S will.
>>
>> There is not a way to differentiate these parts from the
>> hardware or register set.  So this is controlled via the DT
>> to indicate which phy mode is required.  Or the part can be
>> strapped to a certain interface.
>>
>> Data sheet can be found here:
>> http://www.ti.com/product/DP83TC811S-Q1/description
>> http://www.ti.com/product/DP83TC811R-Q1/description
>>
>> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> 
> Hi Dan
> 
> It is normal to add any Reviewed-by, or Tested-by: tags you received,
> so long as you don't make major changes.
> 

Thanks for the reminder.

I usually add them if I get them explicitly stated in the review.

I have not seen any Reviewed-by or Tested-by tags in any of the replies for the
patch.  But I may have missed it.

Dan

>     Andrew
> 


-- 
------------------
Dan Murphy
