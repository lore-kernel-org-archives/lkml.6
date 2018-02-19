Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751978AbeBSAEC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 19:04:02 -0500
Received: from ms.lwn.net ([45.79.88.28]:52220 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751780AbeBSAEB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 19:04:01 -0500
Date: Sun, 18 Feb 2018 17:03:34 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Mauro Carvalho Chehab <mchehab@s-opensource.com>
Cc: Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        Mauro Carvalho Chehab <mchehab@infradead.org>,
        linux-kernel@vger.kernel.org, Jani Nikula <jani.nikula@intel.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Tom Saeger <tom.saeger@oracle.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Matthew Wilcox <mawilcox@microsoft.com>,
        intel-gfx@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 0/6] Add support for in-line nested struct comments
Message-ID: <20180218170334.711d50e2@lwn.net>
In-Reply-To: <cover.1518788761.git.mchehab@s-opensource.com>
References: <cover.1518788761.git.mchehab@s-opensource.com>
Organization: LWN.net
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Feb 2018 11:48:14 -0200
Mauro Carvalho Chehab <mchehab@s-opensource.com> wrote:

> his series fix two bugs at kernel-doc.rst examples and add support
> for in-line nested struct comments.
> 
> It also converts one documentation at intel_dpio_phy to use it,
> in order to give a practical example about how to use it.

OK, I've applied everything but the last patch, which I assume will go
through the DRM tree.

Thanks,

jon
