Return-Path: <SRS0=BQBr=JA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id 90E13C433EF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:50:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4631A208CB
	for <linux-kernel@archiver.kernel.org>; Thu, 14 Jun 2018 20:50:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4631A208CB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=zytor.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755498AbeFNUuQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 Jun 2018 16:50:16 -0400
Received: from terminus.zytor.com ([198.137.202.136]:60711 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755325AbeFNUuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jun 2018 16:50:14 -0400
Received: from hanvin-mobl2.amr.corp.intel.com (jfdmzpr04-ext.jf.intel.com [134.134.139.73])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id w5EKlVA2991278
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Thu, 14 Jun 2018 13:47:32 -0700
Subject: Re: [PATCH v5 2/3] x86/asm: add _ASM_ARG* constants for argument
 registers to <asm/asm.h>
To:     Nick Desaulniers <ndesaulniers@google.com>,
        akpm@linux-foundation.org, mingo@redhat.com, tglx@linutronix.de
Cc:     linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, virtualization@lists.linux-foundation.org,
        astrachan@google.com, manojgupta@google.com, ghackmann@google.com,
        sedat.dilek@gmail.com, tstellar@redhat.com, keescook@google.com,
        yamada.masahiro@socionext.com, michal.lkml@markovi.net,
        linux-kbuild@vger.kernel.org, geert@linux-m68k.org,
        will.deacon@arm.com, mawilcox@microsoft.com, arnd@arndb.de,
        rientjes@google.com, acme@redhat.com, pombredanne@nexb.com,
        aryabinin@virtuozzo.com, kstewart@linuxfoundation.org,
        boris.ostrovsky@oracle.com, jan.kiszka@siemens.com,
        rostedt@goodmis.org, kirill.shutemov@linux.intel.com,
        ard.biesheuvel@linaro.org, akataria@vmware.com,
        brijesh.singh@amd.com, caoj.fnst@cn.fujitsu.com,
        gregkh@linuxfoundation.org, jarkko.sakkinen@linux.intel.com,
        jgross@suse.com, jpoimboe@redhat.com, mka@chromium.org,
        thomas.lendacky@amd.com, tweek@google.com, mjg59@google.com,
        joe@perches.com, andrea.parri@amarulasolutions.com,
        "H. Peter Anvin" <hpa@linux.intel.com>
References: <20180613210518.113983-1-ndesaulniers@google.com>
 <20180613210518.113983-3-ndesaulniers@google.com>
From:   "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <b027a324-ffae-fd5e-d8a3-03934be91a2d@zytor.com>
Date:   Thu, 14 Jun 2018 13:47:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180613210518.113983-3-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/13/18 14:05, Nick Desaulniers wrote:
> From: "H. Peter Anvin" <hpa@linux.intel.com>
> 
> i386 and x86-64 uses different registers for arguments; make them
> available so we don't have to #ifdef in the actual code.
> 
> Native size and specified size (q, l, w, b) versions are provided.
> 
> Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>
> Signed-off-by: H. Peter Anvin <hpa@linux.intel.com>
> Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

I still object to Suggested-by: here.  Sedat did a correction, which is
a Reviewed-by:, but unless I'm completely out to sea, there was no
suggestion on Sedat's part of this; and I had certainly not seen it when
I wrote the code.

	-hpa

