Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965582AbeE2Rgq (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 13:36:46 -0400
Received: from mail.kernel.org ([198.145.29.99]:34310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965464AbeE2Rgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 13:36:42 -0400
Date: Tue, 29 May 2018 19:36:21 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Rob Herring <robh@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>,
        Alvaro Gamez Machado <alvaro.gamez@hazent.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Sasha Levin <alexander.levin@microsoft.com>
Subject: Re: [PATCH 3.18 093/185] microblaze: switch to NO_BOOTMEM
Message-ID: <20180529173621.GA17666@kroah.com>
References: <20180528100050.700971285@linuxfoundation.org>
 <20180528100058.705378203@linuxfoundation.org>
 <CAL_JsqJzkv3Vx_sjhY1fej7adVQZz578E4EGXZuOUWVoQzoJJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJzkv3Vx_sjhY1fej7adVQZz578E4EGXZuOUWVoQzoJJw@mail.gmail.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 29, 2018 at 09:34:33AM -0500, Rob Herring wrote:
> On Mon, May 28, 2018 at 5:02 AM, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > 3.18-stable review patch.  If anyone has any objections, please let me know.
> >
> > ------------------
> >
> > From: Rob Herring <robh@kernel.org>
> >
> > [ Upstream commit 101646a24a2f9cdb61d7732459fbf068a7bbb542 ]
> >
> > Microblaze doesn't set CONFIG_NO_BOOTMEM and so memblock_virt_alloc()
> > doesn't work for CONFIG_HAVE_MEMBLOCK && !CONFIG_NO_BOOTMEM.
> 
> Unless Michal feels differently, I don't think this should go in
> stable. The DT change that broke microblaze is only in 4.16 .

Ah, for some reason I thought it was older than that.

I agree, I'll go drop it from all of the queues now, thanks for the
review, much appreciated.

greg k-h
