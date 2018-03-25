Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753742AbeCYQ4c (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 12:56:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:46858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753482AbeCYQ4a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 12:56:30 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1F486217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jic23@kernel.org
Date: Sun, 25 Mar 2018 17:56:24 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Joe Perches <joe@perches.com>
Cc: William Breathitt Gray <vilhelm.gray@gmail.com>, knaack.h@gmx.de,
        lars@metafoo.de, pmeerw@pmeerw.net, benjamin.gaignard@st.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/8] counter: Introduce the Generic Counter interface
Message-ID: <20180325175624.4cdaaefe@archlinux>
In-Reply-To: <1521963970.24655.16.camel@perches.com>
References: <cover.1520614431.git.vilhelm.gray@gmail.com>
        <e64e423c19d69a9578e95de9db6ca41e231d63da.1520614431.git.vilhelm.gray@gmail.com>
        <20180324173358.571e2fd8@archlinux>
        <1521963970.24655.16.camel@perches.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 25 Mar 2018 00:46:10 -0700
Joe Perches <joe@perches.com> wrote:

> On Sat, 2018-03-24 at 17:33 +0000, Jonathan Cameron wrote:
> > checkpatch.pl --strict (but take into account some of the warnings will
> > be silly so don't fix them all).  
> 
> What checkpatch output is silly?
Sorry - bad word choice.  It guides you to where you should look very
well, but sometimes the patch author should consider the warning and
decide to ignore it.  

Great tool - not magic!

Jonathan

> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
