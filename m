Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752555AbeBPEx6 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Feb 2018 23:53:58 -0500
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34999 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752450AbeBPEx5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Feb 2018 23:53:57 -0500
X-Google-Smtp-Source: AH8x2264pEPs/NTzScxn2KdFLlL0NnQ4n3ptUoyyr2+WEh35S592nOGVraKkz6lynpm0OeQV9q+73Q==
Date: Fri, 16 Feb 2018 07:53:52 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Kees Cook <keescook@chromium.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH 3/3] taint: Add taint for randstruct
Message-ID: <20180216045352.GC7811@avx2>
References: <1518752264-47238-1-git-send-email-keescook@chromium.org>
 <1518752264-47238-4-git-send-email-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1518752264-47238-4-git-send-email-keescook@chromium.org>
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 15, 2018 at 07:37:44PM -0800, Kees Cook wrote:
> +	[ TAINT_RANDSTRUCT ]		= { 'T', ' ', true },

Something like this, yeah.
