Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754041AbeEaH1I (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 03:27:08 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:35819 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753846AbeEaH1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 03:27:04 -0400
X-Google-Smtp-Source: ADUXVKII/4w5PXAxqvHRvzQMDB4FaE27cOSNrQ0jLAjNAc906iJ95IF/+IBPNWlpSe5EkQZMY7XmFw==
From: Matti Vaittinen <mazziesaccount@gmail.com>
X-Google-Original-From: Matti Vaittinen <mvaittin@localhost.localdomain>
Date: Thu, 31 May 2018 10:26:59 +0300
To: Stephen Boyd <sboyd@kernel.org>
Cc: Lee Jones <lee.jones@linaro.org>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        mturquette@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        lgirdwood@gmail.com, broonie@kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mikko.mutanen@fi.rohmeurope.com, heikki.haikola@fi.rohmeurope.com
Subject: Re: [PATCH v2 0/6] mfd/regulator/clk: bd71837: ROHM BD71837 PMIC
 driver
Message-ID: <20180531072659.GI13528@localhost.localdomain>
References: <20180528090003.GA8778@localhost.localdomain>
 <20180529073958.GB4790@dell>
 <20180529083541.GA13528@localhost.localdomain>
 <20180530111649.GB8038@dell>
 <152769382760.144038.10609724773770264610@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152769382760.144038.10609724773770264610@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 30, 2018 at 08:23:47AM -0700, Stephen Boyd wrote:
> Quoting Lee Jones (2018-05-30 04:16:49)
> > On Tue, 29 May 2018, Matti Vaittinen wrote:
> > 
> > > Hello,
> > > 
> > > On Tue, May 29, 2018 at 08:39:58AM +0100, Lee Jones wrote:
> > > > On Mon, 28 May 2018, Matti Vaittinen wrote:
> > > > 
> > > > > Patch series adding support for ROHM BD71837 PMIC.
> > > > FYI, this patch-set is going to be difficult to manage since it was
> > > > not sent 'threaded'.
> > > > 
> > > > If/when you send a subsequent version, could you please ensure you
> > > > send the set threaded so the patches keep in relation to one another
> > > > as they are reviewed?
> > > 
> > > Thanks for the guidance. I have not sent so many patches to community so
> > > I am grateful also from all the practical tips =) Just one slight problem.
> > > I have only seen emails being threaded when one is replying to an email.
> > > So how should I send my patches in same thread? Just send first one and
> > > then send subsequent patches as replies?
> > > 
> > > I just killed some unused definitions and one unused variable from the
> > > code so I am about to send new version. I'll try doing that as a threaded
> > > series and resend all the patches as v3.
> > 
> > You don't need to do this manually.
> > 
> > Just use `git send-email` with the correct arguments.
> > 
> 
> I usually send with 'git send-email *.patch' so that git can do the
> threading for me. Looks like these patches were sent with Mutt though,
> so perhaps 'git format-patch | git imap-send' was used without the
> --thread option on format-patch.

Yep. I used git format-patch without the --thread and mutt -H for
sending. Learned the --thread after Lee pointed out the threading and
used it for further series. Thanks for the help!

Br,
    Matti Vaittinen
