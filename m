Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934834AbeEIMCI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 08:02:08 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:42224 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755541AbeEIMCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 08:02:07 -0400
Date: Wed, 9 May 2018 09:02:01 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Michael Jamet <michael.jamet@intel.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 06/18] docs: core-api: add cgroup-v2 documentation
Message-ID: <20180509090201.145572f1@vento.lan>
In-Reply-To: <20180508095114.0da69ef3@lwn.net>
References: <cover.1525684985.git.mchehab+samsung@kernel.org>
        <b45083a64578b661cabadcf99d509e7def7c21a5.1525684985.git.mchehab+samsung@kernel.org>
        <20180508095114.0da69ef3@lwn.net>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, 8 May 2018 09:51:14 -0600
Jonathan Corbet <corbet@lwn.net> escreveu:

> On Mon,  7 May 2018 06:35:42 -0300
> Mauro Carvalho Chehab <mchehab+samsung@kernel.org> wrote:
> 
> > The cgroup-v2.txt is already in ReST format. So, move it to the
> > core-api guide, where it belongs.
> > 
> > Signed-off-by: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>  
> 
> Honestly, this seems to me like sysadmin material, so I think it should
> go into the admin guide instead.
> 
> Actually, looking at the patch, it seems you agree - it's just the
> changelog that's wrong :)

Yeah, wrong cut-and-paste. Sorry for that.

> I could fix that, but it should probably be posted with a CC to Tejun
> first.

I'll repost it c/c to cgroup maintainers with the right
description.

Thanks,
Mauro
