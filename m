Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAF62C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:56:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BB4020869
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 20:56:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xzQUPpXC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729591AbfA2U45 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 15:56:57 -0500
Received: from vps0.lunn.ch ([185.16.172.187]:59880 "EHLO vps0.lunn.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727570AbfA2U4z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 15:56:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=zTJKlWEER/rZV+/UgWpnxKDpeTfUxymVI7bPJofEpJ8=; b=xzQUPpXCsglXbI1Flfq5XLgaNz
        kWkC8vul5KlIg7pI8r7cBv0AvciXId1oT2Q8K6/0E7ShlSmSoPywfatgiEjk2QtvG93nLFCDmknMS
        8nEUfDCCs55XPJ8mZs79+RTPaMXQETh+GyabS13IKHMm/DPxPl5RylsWokuMTUrLY/14=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.89)
        (envelope-from <andrew@lunn.ch>)
        id 1goaRA-0004pi-4v; Tue, 29 Jan 2019 21:56:52 +0100
Date:   Tue, 29 Jan 2019 21:56:52 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     linux-kernel@vger.kernel.org,
        Emeric Dupont <emeric.dupont@zii.aero>
Subject: Re: [PATCH v3] mfd: tqmx86: IO controller with i2c, wachdog and gpio
Message-ID: <20190129205652.GF13334@lunn.ch>
References: <1547250965-17668-1-git-send-email-andrew@lunn.ch>
 <20190129113532.GB24070@dell>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190129113532.GB24070@dell>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2019 at 11:35:32AM +0000, Lee Jones wrote:
> On Sat, 12 Jan 2019, Andrew Lunn wrote:
> 
> > The QMX86 is a PLD present on some TQ-Systems ComExpress modules. It
> > provides 1 or 2 I2C bus masters, 8 GPIOs and a watchdog timer. Add an
> > MFD which will instantiate the individual drivers.
> > 
> > Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > ---
> > v2:
> > 
> > Drop setting i2c bus speed, which removes the build dependencies on
> > the i2c ocores patches. This can be added back later.
> > 
> > v3
> > --
> 
> You're going to have to resend this.
> 
> Mailers tend to use '--\n' to signify the start of the mail signature
> (see mine as an example), so when someone (myself included) attempts
> to reply to the mail, it is likely that their mailer will chop
> everything from there down.

Hi Lee

I posted a new version.

Your email indicates you are using Mutt:

>User-Agent: Mutt/1.9.4 (2018-02-28)

Which is also what i use. I've never had issues with signatures like
this. I also cannot find any documentation as to how you configure
mutt remove signatures. How are you doing it?

Thanks
	Andrew
