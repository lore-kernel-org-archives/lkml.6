Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1033004AbeBNQxM convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 11:53:12 -0500
Received: from smtp3-1.goneo.de ([85.220.129.38]:41594 "EHLO smtp3-1.goneo.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1032744AbeBNQxL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 11:53:11 -0500
X-Spam-Flag: NO
X-Spam-Score: -2.792
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH 8/8] docs: kernel-doc: Don't mangle literal code blocks in
 comments
From: Markus Heiser <markus.heiser@darmarit.de>
In-Reply-To: <20180207172624.24555-9-corbet@lwn.net>
Date: Wed, 14 Feb 2018 17:53:06 +0100
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        "Tobin C. Harding" <me@tobin.cc>,
        Jani Nikula <jani.nikula@linux.intel.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <B13709B3-563E-4FC6-A8FE-D3A4F0E2E51B@darmarit.de>
References: <20180207172624.24555-1-corbet@lwn.net>
 <20180207172624.24555-9-corbet@lwn.net>
To: Jonathan Corbet <corbet@lwn.net>
X-Mailer: Apple Mail (2.3273)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> Am 07.02.2018 um 18:26 schrieb Jonathan Corbet <corbet@lwn.net>:
> 
> It can be useful to put code snippets into kerneldoc comments; that can be
> done with the "::" operator at the end of a line like this::
> 
>  if (desperate)
>      run_in_circles();
> 
> kernel-doc currently fails to understand these literal blocks and applies
> its normal markup to them, which is then treated as literal by sphinx.  The
> result is unsightly markup instead of a useful code snippet.
> 
> Apply a hack to the output code to recognize literal blocks and avoid
> performing any special markup on them.  It's ugly, but that means it fits
> in well with the rest of the script.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>


[...]

FYI; added similar patch to python version of kernel-doc:

 https://github.com/return42/linuxdoc/commit/3205b8a68

may you like to add regexpr for code-block directive to your patch (jani mentioned already).

-- Markus --
