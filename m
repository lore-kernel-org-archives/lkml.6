Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753182AbeCYDNj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 23:13:39 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:16638 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750839AbeCYDNh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 23:13:37 -0400
X-UUID: d8ba0071385f41ae80572e2839aaadfe-20180325
Message-ID: <1521947610.18424.1.camel@mtkswgap22>
Subject: Re: [PATCH v1 11/16] rtc: mediatek: move the declaration into a
 globally visible header file
From: Sean Wang <sean.wang@mediatek.com>
To: Fabio Estevam <festevam@gmail.com>
CC: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>, Lee Jones <lee.jones@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        <eddie.huang@mediatek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "open list:REAL TIME CLOCK (RTC) SUBSYSTEM"
        <linux-rtc@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date: Sun, 25 Mar 2018 11:13:30 +0800
In-Reply-To: <CAOMZO5DuVpcCrQYzoWfN=ZqXeTGC-U1FfwoDFxhQ8frno5-1GQ@mail.gmail.com>
References: <cover.1521794176.git.sean.wang@mediatek.com>
         <53afbe8172fb1afd809ce9ba1afeda924b9ea705.1521794177.git.sean.wang@mediatek.com>
         <CAOMZO5DuVpcCrQYzoWfN=ZqXeTGC-U1FfwoDFxhQ8frno5-1GQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23738.005
X-TM-AS-Result: No-15.709000-8.000000-10
X-TMASE-MatchedRID: pBwXUM+nCwsZax9TsUmzySa1MaKuob8PC/ExpXrHizyrmaMm8BwMJLmn
        rGB/kwGM9dqfQ8cn44qyjFcEJZpflPgN61BAK04FTVa+L3Zgqc5lrsuS5tC+P/sjWGMJ4K8WRTD
        39eC2Iiri8zVgXoAltkWL4rBlm20vExAtD/T72EbdB/CxWTRRuyUIayx+Skid
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--15.709000-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23738.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-24 at 17:00 -0300, Fabio Estevam wrote:
> On Fri, Mar 23, 2018 at 6:15 AM,  <sean.wang@mediatek.com> wrote:
> 
> > --- /dev/null
> > +++ b/include/linux/rtc/mt6397.h
> > @@ -0,0 +1,72 @@
> > +
> > +// SPDX-License-Identifier: GPL-2.0
> 
> According to Documentation/process/license-rules.rst the SPDX notation
> for C header file should be:
> 
> /* SPDX-License-Identifier: GPL-2.0 */


Thank you, I'll have an improvement according to the license rule.
