Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965679AbeEIQzW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 12:55:22 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36624 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965452AbeEIQzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 12:55:20 -0400
X-Google-Smtp-Source: AB8JxZprsEF2CgGMu0wM4+jFHY99fEduc/BjRe9KaTRDyeKPl85abt3awUmHbhzxGNCpYuXNgqQ8hA==
Date: Wed, 9 May 2018 19:55:17 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: hpa@zytor.com
Cc: tglx@linutronix.de, mingo@redhat.com, linux-kernel@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH] x86: pad assembly functions with INT3
Message-ID: <20180509165517.GD16034@avx2>
References: <20180507213755.GA32406@avx2>
 <EF6BC538-EED3-4718-8AD2-DA2F60B580B1@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <EF6BC538-EED3-4718-8AD2-DA2F60B580B1@zytor.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 02:41:14PM -0700, hpa@zytor.com wrote:
> >-#define __ALIGN		.p2align 4, 0x90
> >+#define __ALIGN		.p2align 4, 0xCC
> 
> Acked-by: H. Peter Anvin <h.peter.anvin@in tel.com>

Thanks!

If someone knows how to control _compiler_ inter-function padding,
please tell.
