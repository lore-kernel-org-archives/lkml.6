Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751218AbeCIOjw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 09:39:52 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33097 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751143AbeCIOjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 09:39:51 -0500
X-Google-Smtp-Source: AG47ELv5YoCWxxRUwEqQj6vlmBTZ8A7Tlb+X7Ofj4sP3QVaHfLV1JySaVhO3C19RMaiQaLBoO3r4GQ==
Date: Fri, 9 Mar 2018 09:39:47 -0500
From: Matt Porter <mporter@konsulko.com>
To: Rob Herring <robh@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Mark Rutland <mark.rutland@arm.com>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: add tda7419 audio processor binding
Message-ID: <20180309143947.vxmzuqmlwdyf2gpd@bacon.ohporter.com>
References: <20180227225128.17815-1-mporter@konsulko.com>
 <20180227225128.17815-2-mporter@konsulko.com>
 <20180305222954.chitmlvsklszods7@rob-hp-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305222954.chitmlvsklszods7@rob-hp-laptop>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 04:29:54PM -0600, Rob Herring wrote:
> On Tue, Feb 27, 2018 at 05:51:27PM -0500, Matt Porter wrote:
> > DeviceTree binding for the tda7419 audio processor.
> > 
> > Signed-off-by: Matt Porter <mporter@konsulko.com>
> > ---
> >  Documentation/devicetree/bindings/sound/tda7419.txt | 15 +++++++++++++++
> >  1 file changed, 15 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/sound/tda7419.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/sound/tda7419.txt b/Documentation/devicetree/bindings/sound/tda7419.txt
> > new file mode 100644
> > index 000000000000..919318315600
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/sound/tda7419.txt
> > @@ -0,0 +1,15 @@
> > +TDA7419 audio processor
> > +
> > +This device supports I2C only.
> > +
> > +Required properties:
> > +
> > +- compatible : "st,tda7419"
> > +- reg : the I2C address of the device.
> 
> For completeness:
> 
> st,mute-gpios for MUTE pin?

I'll add mute in as an optional property.

> 
> vdd-supply?

Yes, there's a required ~8.5V supply so I'll add the regulator reference.

Thanks,
Matt
