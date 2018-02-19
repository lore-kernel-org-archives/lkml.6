Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752547AbeBSK2r (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 05:28:47 -0500
Received: from mx0b-001ae601.pphosted.com ([67.231.152.168]:46254 "EHLO
        mx0b-001ae601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752380AbeBSK2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 05:28:45 -0500
Authentication-Results: ppops.net;
        spf=none smtp.mailfrom=ckeepax@opensource.cirrus.com
Date: Mon, 19 Feb 2018 10:28:38 +0000
From: Charles Keepax <ckeepax@opensource.cirrus.com>
To: Rob Herring <robh@kernel.org>
CC: <lee.jones@linaro.org>, <mark.rutland@arm.com>,
        <linus.walleij@linaro.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>
Subject: Re: [PATCH 2/2] mfd: arizona: Update DT doc to support more standard
 reset binding
Message-ID: <20180219102838.mcu3wkrvfkaf2ty4@localhost.localdomain>
References: <20180214155512.17218-1-ckeepax@opensource.cirrus.com>
 <20180214155512.17218-2-ckeepax@opensource.cirrus.com>
 <20180219031335.75rw2bdlyrxjt4ff@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180219031335.75rw2bdlyrxjt4ff@rob-hp-laptop>
User-Agent: NeoMutt/20170113 (1.7.2)
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1711220000
 definitions=main-1802190131
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 18, 2018 at 09:13:35PM -0600, Rob Herring wrote:
> On Wed, Feb 14, 2018 at 03:55:12PM +0000, Charles Keepax wrote:
> > Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/arizona.txt | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
> > index bdd017686ea5..a1557220825e 100644
> > --- a/Documentation/devicetree/bindings/mfd/arizona.txt
> > +++ b/Documentation/devicetree/bindings/mfd/arizona.txt
> > @@ -50,7 +50,7 @@ Required properties:
> >  
> >  Optional properties:
> >  
> > -  - wlf,reset : GPIO specifier for the GPIO controlling /RESET
> > +  - wlf,reset-gpios : GPIO specifier for the GPIO controlling /RESET
> 
> Just reset-gpios is widely used, so you can use that and drop the 
> vendor.
> 

Yes sorry should have realised that will drop the prefix and
resend.

Thanks,
Charles
