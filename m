Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753842AbeDJTmT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 15:42:19 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34889 "EHLO
        mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753267AbeDJTlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 15:41:23 -0400
X-Google-Smtp-Source: AIpwx4+uOMTty1zQn9zBh2MsMtKh2+iZQviCoZrVviPhMtzLWz0HUgv5N521NxZ4yG0NWp479SH+2w==
Date: Tue, 10 Apr 2018 21:41:19 +0200
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To: Joey Pabalinas <joeypabalinas@gmail.com>
Cc: linux-sparse@vger.kernel.org, Kees Cook <keescook@chromium.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Martin Uecker <Martin.Uecker@med.uni-goettingen.de>,
        Al Viro <viro@ZenIV.linux.org.uk>, Christopher Li <sparse@chrisli.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] sparse: add -Wpointer-arith flag to toggle
 sizeof(void) warnings
Message-ID: <20180410194117.ei4eo3kaxvv2ezdx@ltop.local>
References: <20180410010204.qeudkkru4jilun3v@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410010204.qeudkkru4jilun3v@gmail.com>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 09, 2018 at 03:02:04PM -1000, Joey Pabalinas wrote:
> Recent changes to the min()/max() macros in include/linux/kernel.h
> have added a lot of noise when compiling the kernel with Sparse checking
> enabled. This mostly is due to the *huge* increase in the number of
> sizeof(void) warnings, a larger number of which can safely be ignored.
> 

Thank you very much.

There is just a problem with the test but it's my fault as I
pointed to you to my tree but the master tree lack a lot of fixes
and have problems when dereferencing function pointers.
So, for the master tree, I propose to use a version with these
tests removed:
	git://github.com/lucvoo/sparse-dev.git pointer-arith-v3

Cheers,
-- Luc
