Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbeFDLog (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 07:44:36 -0400
Received: from mga14.intel.com ([192.55.52.115]:7233 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751418AbeFDLoe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 07:44:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,476,1520924400";
   d="scan'208";a="234205007"
Message-ID: <7bdb658727b364e275c121a3bdd351f183d56cb9.camel@linux.intel.com>
Subject: Re: [PATCH 0/8] serial: 8250: Add 485 emulation to 8250_dw.
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>, Kees Cook <keescook@chromium.org>,
        Matthias Brugger <mbrugger@suse.com>,
        Allen Pais <allen.lkml@gmail.com>, Sean Young <sean@mess.org>,
        Ed Blake <ed.blake@sondrel.com>,
        Stefan Potyra <Stefan.Potyra@elektrobit.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Joshua Scott <joshua.scott@alliedtelesis.co.nz>,
        Vignesh R <vigneshr@ti.com>,
        Rolf Evers-Fischer <rolf.evers.fischer@aptiv.com>,
        Aaron Sierra <asierra@xes-inc.com>,
        Rafael Gago <rafael.gago@gmail.com>, Joel Stanley <joel@jms.id.au>,
        Sean Wang <sean.wang@mediatek.com>, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Mon, 04 Jun 2018 14:44:28 +0300
In-Reply-To: <c14c671c-3240-0170-7c0e-2b195c5b1398@micronovasrl.com>
References: <20180601124021.102970-1-giulio.benetti@micronovasrl.com>
         <65c26f5db1275e958cfe6390e9336568b0158dea.camel@linux.intel.com>
         <CAJs94EZEEBNZRU3ixkdG9w44xsQDi7MUYAya2dzkAErT=xwqVA@mail.gmail.com>
         <c14c671c-3240-0170-7c0e-2b195c5b1398@micronovasrl.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-06-04 at 12:42 +0200, Giulio Benetti wrote:

> > > I don't see in Cc list author of rs485 code, who might be
> > > interested in
> > > this.
> > > 
> > > So, added him here.
> 
> Thanks Andy for adding in Cc an reviewing.
> Dumb question: how did you find him?

I'm just following mailing lists somehow.
Though you always can do `git annotate` to see who lately did change
what.

> I thought he was between people on get_maintainer.pl output.

Hmm... probably. Never checked myself for this particular case.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
