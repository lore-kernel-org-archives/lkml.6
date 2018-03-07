Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934153AbeCGRMr (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:12:47 -0500
Received: from ms.lwn.net ([45.79.88.28]:58426 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933774AbeCGRMj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:12:39 -0500
Date: Wed, 7 Mar 2018 10:12:38 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Matthew Wilcox <willy@infradead.org>
Cc: Takashi Iwai <tiwai@suse.de>, Jani Nikula <jani.nikula@intel.com>,
        Jiri Slaby <jslaby@suse.cz>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] Documentation/sphinx: Fix Directive import error
Message-ID: <20180307101238.44c88415@lwn.net>
In-Reply-To: <20180302184014.GG31400@bombadil.infradead.org>
References: <20180302152831.11510-1-tiwai@suse.de>
        <20180302184014.GG31400@bombadil.infradead.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2 Mar 2018 10:40:14 -0800
Matthew Wilcox <willy@infradead.org> wrote:

> Sphinx 1.7 removed sphinx.util.compat.Directive so people
> who have upgraded cannot build the documentation.  Switch to
> docutils.parsers.rst.Directive which has been available since
> docutils 0.5 released in 2009.
> 
> Bugzilla: https://bugzilla.opensuse.org/show_bug.cgi?id=1083694
> Co-developed-by: Takashi Iwai <tiwai@suse.de>
> Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>

FWIW, I've *finally* gotten a chance to test this with a few sphinx
versions; it works just fine, of course.  Will get it upstream shortly.

Thanks,

jon
