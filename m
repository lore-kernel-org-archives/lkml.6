Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753138AbeBSPjU (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:39:20 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33076 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753016AbeBSPjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:39:18 -0500
X-Google-Smtp-Source: AH8x225DG6PoMEVaMclZ3gjMt6cCVI4PhSYKuL7qA15g8RdulxviglLAPamBHJ5s/ilif8Sr2/zmTw==
Date: Mon, 19 Feb 2018 16:39:13 +0100
From: Daniel Vetter <daniel@ffwll.ch>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>, Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, Tom Saeger <tom.saeger@oracle.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [Intel-gfx] [PATCH 0/6] Add support for in-line nested struct
 comments
Message-ID: <20180219153913.GU22199@phenom.ffwll.local>
Mail-Followup-To: Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Jani Nikula <jani.nikula@intel.com>,
        intel-gfx@lists.freedesktop.org, Tom Saeger <tom.saeger@oracle.com>,
        linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
References: <cover.1518788761.git.mchehab@s-opensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1518788761.git.mchehab@s-opensource.com>
X-Operating-System: Linux phenom 4.14.0-3-amd64 
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 16, 2018 at 11:48:14AM -0200, Mauro Carvalho Chehab wrote:
> This series fix two bugs at kernel-doc.rst examples and add support
> for in-line nested struct comments.
> 
> It also converts one documentation at intel_dpio_phy to use it,
> in order to give a practical example about how to use it.
> 
> Mauro Carvalho Chehab (6):
>   doc-guide: kernel-doc: fix example for nested_foobar struct
>   doc-guide: kernel-doc: fix example for inlined comments
>   doc-guide: kernel-doc: move in-line section to be after nested struct
>   scripts: kernel-doc: support in-line comments on nested structs/unions
>   doc-guide: kernel-doc: add examples about nested union/structs
>   drm: intel_dpio_phy: fix kernel-doc comments at nested struct

Oh, this is cool. Thanks a lot for doing this.
-Daniel

> 
>  Documentation/doc-guide/kernel-doc.rst | 69 ++++++++++++++++++++--------------
>  drivers/gpu/drm/i915/intel_dpio_phy.c  |  2 +-
>  scripts/kernel-doc                     |  2 +-
>  3 files changed, 43 insertions(+), 30 deletions(-)
> 
> -- 
> 2.14.3
> 
> 
> _______________________________________________
> Intel-gfx mailing list
> Intel-gfx@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/intel-gfx

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
