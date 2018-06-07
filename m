Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id x46PDQuSGVuVOAAAmS7hNA
	; Thu, 07 Jun 2018 20:14:05 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id 293BB6074D; Thu,  7 Jun 2018 20:14:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id B72AE60290;
	Thu,  7 Jun 2018 20:14:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B72AE60290
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932181AbeFGUOB (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Thu, 7 Jun 2018 16:14:01 -0400
Received: from mga18.intel.com ([134.134.136.126]:28303 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751037AbeFGUOA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jun 2018 16:14:00 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Jun 2018 13:13:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,487,1520924400";
   d="scan'208";a="47283802"
Received: from kdmease-mobl.amr.corp.intel.com (HELO hanvin-mobl2.amr.corp.intel.com) ([10.254.24.193])
  by orsmga007.jf.intel.com with ESMTP; 07 Jun 2018 13:13:57 -0700
Subject: Re: [PATCH v3 2/3] x86/asm: add _ASM_ARG* constants for argument
 registers to <asm/asm.h>
To: Nick Desaulniers <ndesaulniers@google.com>,
        akpm@linux-foundation.org, hpa@zytor.com, mingo@redhat.com,
        tglx@linutronix.de
Cc: linux-efi@vger.kernel.org, linux-kernel@vger.kernel.org,
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
        joe@perches.com
References: <20180607183219.192973-1-ndesaulniers@google.com>
 <20180607183219.192973-3-ndesaulniers@google.com>
From: "H. Peter Anvin" <hpa@linux.intel.com>
Message-ID: <2f7fc4bf-d0fe-0d3a-ffdd-02cc82c83747@linux.intel.com>
Date: Thu, 7 Jun 2018 13:13:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20180607183219.192973-3-ndesaulniers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/07/18 11:32, Nick Desaulniers wrote:
> 
> Suggested-by: Sedat Dilek <sedat.dilek@gmail.com>

If this was suggested by Sedat, I didn't see that suggestion...

	-hpa
