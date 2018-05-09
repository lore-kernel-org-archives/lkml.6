Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934820AbeEIMBF (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:01:05 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42172 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeEIMBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:01:02 -0400
Date: Wed, 9 May 2018 09:00:57 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 15/18] iio: iio.h: use nested struct support on
 kernel-doc markup
Message-ID: <20180509090057.23051846@vento.lan>
In-Reply-To: <20180507180803.21e967b2@archlinux>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
        <1a31240699b1b6ee089b5b36889ab27ae14ad94e.1525684985.git.mchehab+samsung@kernel.org>
        <20180507180803.21e967b2@archlinux>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, 7 May 2018 18:08:03 +0100
Jonathan Cameron <jic23@kernel.org> escreveu:

> On Mon,  7 May 2018 06:35:51 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > Solve those Sphinx warnings:
> > 
> >     ./include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.sign' not described in 'iio_chan_spec'
> >     ./include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.realbits' not described in 'iio_chan_spec'
> >     ./include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.storagebits' not described in 'iio_chan_spec'
> >     ./include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.shift' not described in 'iio_chan_spec'
> >     ./include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.repeat' not described in 'iio_chan_spec'
> >     ./include/linux/iio/iio.h:270: warning: Function parameter or member 'scan_type.endianness' not described in 'iio_chan_spec'
> > 
> >     ./include/linux/iio/iio.h:191: WARNING: Unexpected indentation.
> >     ./include/linux/iio/iio.h:192: WARNING: Block quote ends without a blank line; unexpected unindent.
> >     ./include/linux/iio/iio.h:198: WARNING: Definition list ends without a blank line; unexpected unindent.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> Great thanks.  I couldn't figure out how to do this last time
> I looked at it.

Support for nested structs were only recently introduced :-)

> 
> Applied to the togreg branch of iio.git and pushed out as testing for
> the autobuilders to ignore it.

Thanks!
Mauro
