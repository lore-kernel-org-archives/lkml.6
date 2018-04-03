Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752388AbeDCROP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 13:14:15 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:39187 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751469AbeDCROM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 13:14:12 -0400
X-Google-Smtp-Source: AIpwx4/HUESXpraBo4bhGpn/Pg6pB/DfYz3ct8GPl6KXX9phbnb8E58M3YL6qwUOLA1iG5PcowmUCA==
Date: Tue, 3 Apr 2018 22:44:01 +0530
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?utf-8?B?5YiY54Kc?= <liuwei@actions-semi.com>, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree <devicetree@vger.kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>, amit.kucheria@linaro.org,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        hzhang@ucrobotics.com, bdong@ucrobotics.com,
        Mani Sadhasivam <manivannanece23@gmail.com>
Subject: Re: [PATCH v6 3/9] pinctrl: actions: Add Actions S900 pinctrl driver
Message-ID: <20180403171401.etcvqe4xrkcl7sbh@linaro.org>
References: <20180328174703.19778-1-manivannan.sadhasivam@linaro.org>
 <20180328174703.19778-4-manivannan.sadhasivam@linaro.org>
 <CAHp75VeRh9hORs=4nPqc=rUOCRzAfp0z2_1_xpJUScAeE07yqw@mail.gmail.com>
 <20180403170016.w3scjt57ssvk6zyi@linaro.org>
 <d86b21a7-e269-6c27-c0e7-d46bee8e5c1d@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d86b21a7-e269-6c27-c0e7-d46bee8e5c1d@suse.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 03, 2018 at 07:03:46PM +0200, Andreas Färber wrote:
> Hi Mani,
> 
> Am 03.04.2018 um 19:00 schrieb Manivannan Sadhasivam:
> > On Sat, Mar 31, 2018 at 12:16:49AM +0300, Andy Shevchenko wrote:
> >> On Wed, Mar 28, 2018 at 8:46 PM, Manivannan Sadhasivam
> >> <manivannan.sadhasivam@linaro.org> wrote:
> >>> +static const struct pinconf_ops owl_pinconf_ops = {
> >>> +       .is_generic = true,
> >>> +       .pin_config_get = owl_pin_config_get,
> >>> +       .pin_config_set = owl_pin_config_set,
> >>> +       .pin_config_group_get = owl_group_config_get,
> >>> +       .pin_config_group_set = owl_group_config_set
> >>
> >> It's still good idea to leave comma here...
> >>
> > 
> > I'm confused. What is the criteria for removing/keeping comma for last member
> > of struct? I followed your gpio driver suggestion.
> 
> No comma for list terminator ("{}") because nothing goes after it; comma
> whenever it allows adding a new line without touching the old one, i.e.
> keeping future diff small.
>

Thanks for the clarification Andreas! Keeping the future diff small is the
key, understood.

Thanks,
Mani
 
> Cheers,
> Andreas
> 
> -- 
> SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
> GF: Felix Imendörffer, Jane Smithard, Graham Norton
> HRB 21284 (AG Nürnberg)
