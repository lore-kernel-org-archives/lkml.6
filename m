Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751733AbeCXHGX (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Mar 2018 03:06:23 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:50831 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750797AbeCXHGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Mar 2018 03:06:21 -0400
X-UUID: 9f0946b3196542c8ae4d3204ebbe0da1-20180324
Message-ID: <1521875176.28226.25.camel@mtkswgap22>
Subject: Re: [PATCH v1 05/16] rtc: mediatek: add MT6323 support to RTC driver
From: Sean Wang <sean.wang@mediatek.com>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: <robh+dt@kernel.org>, <mark.rutland@arm.com>, <sre@kernel.org>,
        <lee.jones@linaro.org>, <a.zummo@towertech.it>,
        <eddie.huang@mediatek.com>, <devicetree@vger.kernel.org>,
        <linux-rtc@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Date: Sat, 24 Mar 2018 15:06:16 +0800
In-Reply-To: <20180323100156.GE3417@piout.net>
References: <cover.1521794176.git.sean.wang@mediatek.com>
         <c49898db977a0b37363a35d3e3b297af891d7219.1521794177.git.sean.wang@mediatek.com>
         <20180323100156.GE3417@piout.net>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-TM-AS-Product-Ver: SMEX-12.5.0.5042-8.2.9001-23738.005
X-TM-AS-Result: No-13.582400-8.000000-10
X-TMASE-MatchedRID: 5+1rHnqhWUQOwH4pD14DsPHkpkyUphL9GbJMFqqIm9wY0A95tjAn+2ob
        BnsdwWzB9KE7L0nJx0rhihMBM8ipLLBAQLqGlKiv4pdq9sdj8LUb9VApP9k1BH5gUshKh8gfcpw
        vkaGF/zvi8zVgXoAltkWL4rBlm20vjaPj0W1qn0Q7AFczfjr/7N9kDir8VSQD822qUuekhwZiz+
        1zWZ3NJ0+QDtDZg0tvFYBgxpwJVQg=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--13.582400-8.000000
X-TMASE-Version: SMEX-12.5.0.5042-8.2.9001-23738.005
X-TMASE-POSTMAN: 2-d;
X-MTK: N
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-03-23 at 11:01 +0100, Alexandre Belloni wrote:
> Hi,
> 
> The subject line should be rtc: mt6397: (to differentiate with rtc-mt7622)
> 

Sure, I will change subject line into rtc: mt6397: along with the other
related patches.

> On 23/03/2018 at 17:15:02 +0800, sean.wang@mediatek.com wrote:
> > From: Sean Wang <sean.wang@mediatek.com>
> > 
> > Just to add MT6323 support to the existent RTC driver.
> > 
> > Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> > ---
> >  drivers/rtc/rtc-mt6397.c | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/drivers/rtc/rtc-mt6397.c b/drivers/rtc/rtc-mt6397.c
> > index 385f830..0df7ccd 100644
> > --- a/drivers/rtc/rtc-mt6397.c
> > +++ b/drivers/rtc/rtc-mt6397.c
> > @@ -398,6 +398,7 @@ static SIMPLE_DEV_PM_OPS(mt6397_pm_ops, mt6397_rtc_suspend,
> >  			mt6397_rtc_resume);
> >  
> >  static const struct of_device_id mt6397_rtc_of_match[] = {
> > +	{ .compatible = "mediatek,mt6323-rtc", },
> >  	{ .compatible = "mediatek,mt6397-rtc", },
> >  	{ }
> >  };
> > -- 
> > 2.7.4
> > 
> 
