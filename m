Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753250AbeDCUIn convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 16:08:43 -0400
Received: from mail.bootlin.com ([62.4.15.54]:59279 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752650AbeDCUIm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 16:08:42 -0400
Date: Tue, 3 Apr 2018 22:08:39 +0200
From: =?UTF-8?B?TXlsw6huZQ==?= Josserand <mylene.josserand@bootlin.com>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>,
        devicetree <devicetree@vger.kernel.org>, quentin.schulz@bootlin.com,
        Marc Zyngier <marc.zyngier@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        LABBE Corentin <clabbe.montjoie@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v5 11/13] ARM: sun9i: smp: Add is_sun9i field
Message-ID: <20180403220839.0ec8f9b8@dell-desktop.home>
In-Reply-To: <CAGb2v67EzOHd5_Xj9K3ZuAKVZhA4WrwfTM0gE_eR+H4mF1J4eA@mail.gmail.com>
References: <20180403061836.3926-1-mylene.josserand@bootlin.com>
        <20180403061836.3926-12-mylene.josserand@bootlin.com>
        <20180403084655.x6u7s4jzqdvq2eey@flea>
        <CAGb2v67EzOHd5_Xj9K3ZuAKVZhA4WrwfTM0gE_eR+H4mF1J4eA@mail.gmail.com>
Organization: Bootlin
X-Mailer: Claws Mail 3.14.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, 3 Apr 2018 16:48:41 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> On Tue, Apr 3, 2018 at 4:46 PM, Maxime Ripard <maxime.ripard@bootlin.com> wrote:
> > On Tue, Apr 03, 2018 at 08:18:34AM +0200, Mylène Josserand wrote:  
> >> To prepare the support of sun8i-a83t, add a field in the smp_data
> >> structure to enable the case of sun9i.
> >>
> >> Start to handle the differences between sun9i-a80 and sun8i-a83t
> >> by using this variable.
> >>
> >> Add an index to retrieve which structures we are using.  
> >
> > This should have been in a separate commit, but maybe we can store a
> > pointer to the array cell we're using instead of always using the
> > index?  
> 
> Using a pointer would also avoid some of the code movement from the
> previous patch.
> 
> ChenYu

Yep, I will use a pointer instead. Thanks for the correction.

Best regards,

-- 
Mylène Josserand, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
