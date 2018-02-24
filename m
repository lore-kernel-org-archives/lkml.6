Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751530AbeBXVR1 (ORCPT <rfc822;w@1wt.eu>);
        Sat, 24 Feb 2018 16:17:27 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35386 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751428AbeBXVR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Feb 2018 16:17:26 -0500
X-Google-Smtp-Source: AG47ELssGKZ8kj4LajVddBFeRLdgC9J7zMpHT+9OFwaAK4hIf4cfMoEqj7y9L1wnWppsD06wf55MRg==
Date: Sun, 25 Feb 2018 00:17:22 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: gustavoleite.ti@gmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] linux/kernel.h: break long lines
Message-ID: <20180224211722.GA20603@avx2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.7.2 (2016-11-26)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> -static inline int __must_check kstrtol(const char *s, unsigned int base, long *res)
> +static inline int __must_check kstrtol(const char *s, unsigned int base,
> +		long *res)

Please find and fix a bug instead of making feel-good changes.
