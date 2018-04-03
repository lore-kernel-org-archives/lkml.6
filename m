Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752845AbeDCRcG (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:32:06 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:10850 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752515AbeDCRcB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:32:01 -0400
X-UUID: 182b9e8e680041cda79addd0aeccb837-20180404
Message-ID: <1522776711.12959.1.camel@mtkswgap22>
Subject: Re: [PATCH net] net: dsa: mt7530: Use NULL instead of plain integer
From: Sean Wang <sean.wang@mediatek.com>
To: Florian Fainelli <f.fainelli@gmail.com>
CC: <netdev@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@savoirfairelinux.com>,
        open list <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Date: Wed, 4 Apr 2018 01:31:51 +0800
In-Reply-To: <f5aa0467-8124-b097-2b89-dcf1698a5ba5@gmail.com>
References: <20180402232414.19671-1-f.fainelli@gmail.com>
         <1522721904.18424.51.camel@mtkswgap22>
         <f5aa0467-8124-b097-2b89-dcf1698a5ba5@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23762.000
X-TM-AS-Result: No-14.225000-8.000000-10
X-TMASE-MatchedRID: wQVy7q402w2Fh/7ZHArNZya1MaKuob8PC/ExpXrHizyrmaMm8BwMJLmn
        rGB/kwGMvqKlPiBL76fer8mrTnO76o0To7oIUo/i7TLIvnWov9F+K68qL2G5pqj5v7I4/SgY+lM
        TBggE22Hi8zVgXoAltkWL4rBlm20vZiFQvkZhFu1q8/xv2Um1avoLR4+zsDTtGM6W3U+Lnnd66b
        Y/H2Tl/9GMBuiZp3MPHNIopW7peJywbar+3aE25Q==
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--14.225000-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23762.000
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-03 at 10:02 -0700, Florian Fainelli wrote:
> On 04/02/2018 07:18 PM, Sean Wang wrote:
> > On Mon, 2018-04-02 at 16:24 -0700, Florian Fainelli wrote:
> >> We would be passing 0 instead of NULL as the rsp argument to
> >> mt7530_fdb_cmd(), fix that.
> >>
> > 
> > Acked-by: Sean Wang <sean.wang@mediatek.com>
> > 
> > BTW, does the part of the commit message should be updated with "passing
> > NULL instead of 0"?
> 
> I don't follow you, the commit message indicates what we were doing
> which implies it was wrong and fixes it. Would you want me to reword
> that part?

thanks for the explanation.

the commit message is clear and okay for me now
