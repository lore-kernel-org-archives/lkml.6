Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751285AbeBINcg (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 08:32:36 -0500
Received: from ms.lwn.net ([45.79.88.28]:59756 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750924AbeBINce (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 08:32:34 -0500
Date: Fri, 9 Feb 2018 06:32:31 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Jani Nikula <jani.nikula@linux.intel.com>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mchehab@kernel.org, me@tobin.cc
Subject: Re: [PATCH 1/8] docs: kernel-doc: Get rid of xml_escape() and
 friends
Message-ID: <20180209063231.349ad487@lwn.net>
In-Reply-To: <87inb6a5rs.fsf@intel.com>
References: <20180207172624.24555-1-corbet@lwn.net>
        <20180207172624.24555-2-corbet@lwn.net>
        <87inb6a5rs.fsf@intel.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Feb 2018 11:09:27 +0200
Jani Nikula <jani.nikula@linux.intel.com> wrote:

> On Wed, 07 Feb 2018, Jonathan Corbet <corbet@lwn.net> wrote:
> > XML escaping is a worry that came with DocBook, which we no longer have any
> > dealings with.  So get rid of the useless xml_escape()/xml_unescape()
> > functions.  No change to the generated output.  
> 
> I think this will break at least the -docbook output option, perhaps
> also -html and -html5 options. If you think it's okay to break them,
> would it not be better to just axe those off first?
> 
> I guess this boils down to, is kernel-doc the script a general purpose
> tool, or just a very specific part of the kernel documentation build
> process?
> 
> FWIW I think the latter, and why don't you throw docbook/html support
> out already!

See commit b05142675310 :)

Thanks,

jon
