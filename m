Return-Path: <SRS0=IQwf=QG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87848C282D7
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 47DFD218AC
	for <linux-kernel@archiver.kernel.org>; Wed, 30 Jan 2019 20:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732498AbfA3UYH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 30 Jan 2019 15:24:07 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:51261 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727269AbfA3UYH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Jan 2019 15:24:07 -0500
Received: from oxbaltgw60.schlund.de ([172.19.246.147]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1N5FQJ-1hGwsM0VUb-011CkM; Wed, 30 Jan 2019 21:23:35 +0100
Date:   Wed, 30 Jan 2019 21:23:31 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Kamil Debski <kamil@wypas.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Jean Delvare <jdelvare@suse.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Message-ID: <625436113.118199.1548879811777@email.ionos.de>
In-Reply-To: <20190130172815.GC14781@roeck-us.net>
References: <1548860827-29796-1-git-send-email-stefan.wahren@i2se.com>
 <1548860827-29796-2-git-send-email-stefan.wahren@i2se.com>
 <20190130172815.GC14781@roeck-us.net>
Subject: Re: [PATCH RFC 1/3] dt-bindings: hwmon: Add tachometer interrupt to
 pwm-fan
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:ih27qXxjTclNJJD/XT4Nm1XZiqtxNMZXqH4PQj/w86o8ZiLtSoV
 NqRMvylY66tBKpaGjYIg5uU8lvJ4b2bL6vxwYTkmkWjXWxhWuAz1pV0uDmE0B54iyeCSuuR
 pvZxZ92h2pGAV/d7Z7IlcurBBnlUpmeBuuHbwGxjD19tkUInN4bwOSJQGVDD9HEQIFq6Ngv
 XtHNSqz2bQPVnIlYGaXSA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UNWpgb3YUVg=:W0z1c/uwrEaKt40gbayUSN
 29tHO2ls5cAPEWYcAuhe6coeu3fS2/2a0e3MOgQX9sQtgJ/VDA4pCWWTW11rzgbPbae0ptMys
 X+sBwbHIAcFvx5/P3ENW6Pgf0WVBXtdvmphJoEztCSucAHz+K5/Cr+J9SS0rJftRXARD00veA
 lZfhzkdkZSl/OrO8CNBQkDnBr5nMP2MuDVV0Kr2gKqAhT6IoeP5hAJig1dFSymr1Mq/q2X4T1
 PDdOn5o374YsAxj+Dw/tPlCTuU8c6tUewXkhIx2gc6jdMFjnUbMSoy8balgCKUmWTHjmRtvVf
 ye+nMH2xK2Z4+IrE0MFINKV1psQcNeLnbjCq0d/XFAiW4hCtUc+nAL5Gg8ZURB+S/MFNAc7mb
 DEUIxeNUtq5VZiENgwb4GnZ0IYlgr1CNNzGcIZDsqKbVI5vPLH5nVmYrqTQ8W6HhP61wBrZmG
 baastXJy7Y2Gy0oCTpNVXntuE7wcxJWjIal7eNizYf8lT82hSyVQD8xiXFJ30HWQJtF8F+7tJ
 4CVtVkrstFlR4kHkDdi/yIe0PUmOAdqjvuXEv4VV+E3n8httS+A4N1zNubvGXyD/wryz6QFQ5
 zcphl8rJR4Mk8+dKCDVM+NjZdtJ6NKk6DIfA1KKYw8bcE0O1Z2Dr+5t6BXst11BXAPGGwJ8rJ
 lJEb414XfeolNKsHxhWRn/o4Y4EA8l/CXV2G3Q4Pl5bTB/KPl4hLE0QBFFfgm1W6s/DAf0AVX
 mR0rrZRss+z0IvBoSAZICTdUZmpNKg+1+psU0/NRZc9qiA8zwciFv7plPsc=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guenter,

> Guenter Roeck <linux@roeck-us.net> hat am 30. Januar 2019 um 18:28 geschrieben:
> 
> 
> On Wed, Jan 30, 2019 at 04:07:05PM +0100, Stefan Wahren wrote:
> > This adds the tachometer interrupt to the pwm-fan binding, which is
> > necessary for RPM support.
> > 
> > Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
> > ---
> >  Documentation/devicetree/bindings/hwmon/pwm-fan.txt | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> > index 49ca5d8..7f69b0b 100644
> > --- a/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> > +++ b/Documentation/devicetree/bindings/hwmon/pwm-fan.txt
> > @@ -8,6 +8,9 @@ Required properties:
> >  
> >  Optional properties:
> >  - fan-supply    : phandle to the regulator that provides power to the fan
> > +- interrupts    : contains a single interrupt specifier which describes the
> > +                  tachometer pin output of a 2 pulse-per-revolution fan.
> > +                  See interrupt-controller/interrupts.txt for the format.
> 
> So a hypothetical {1,4} pulse-per-revolution fan would explicitly not be
> supported ? Why ?

i could add an additional property to specify the pulse per revolution and use the 2 as default (according to the Intel spec for 4 pin pwm fan) which should fit in most cases.

> 
> Guenter
