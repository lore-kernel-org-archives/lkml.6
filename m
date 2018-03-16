Return-Path: <linux-kselftest-owner@vger.kernel.org>
X-Google-Smtp-Source: AG47ELuKDL1bf9YD0EK6INbaM72G1kTP7ONk+03hMGssPRGSrnrwpkERZnYX+m2FqbiPgsNUjdVY
ARC-Seal: i=1; a=rsa-sha256; t=1521237336; cv=none;
        d=google.com; s=arc-20160816;
        b=cbv3RmhL3oAEBBcPGC4wkfldp1QeS31HjWz4eeUmODyHVm5wyK5S7LSVdRqnBw6wv5
         PLsG7e80rufwjZbOyb80yH9ErnwnVwj+JZ7aoDUfXmyxfWMdBSwmY/UptjqF+IWlat6l
         GUXy9IFpeTphtGHkQI/Q1wYZVgLGUdtk2I0rVBJOG0t31+LFQw7IXNg1eFGQ69xHDrYH
         PoqMpgUGVJUzxWiqZLvPmm0ft9SBZAAw44EERW7vRrMFr1tPlFMKybpmeJdLyAfT1p2Z
         SYWFFiVb+340Q45eiJzFRGhD+tgb0ir91HI7L5FRey7Y2qkgpd/sbJJGsVK1IsSghSAy
         O1Zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=list-id:precedence:sender:content-transfer-encoding
         :content-language:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=3NZZrPO8Ve0CF39lD5uIaQafLLwiiBJfFyiOVIWAkZU=;
        b=0xJPMj6b/msty7p9AP3m/KQRbk2DFLDHzfxWLYN6wq2wQRJM4e74h9NHa6iCiOVzRa
         uoO1LMiHZ6VbLkboKPgUSF2QA0qixTS2otdWqHU6K3YWfmzW2x2flYK/Rex+E3qTSneR
         9m7cfW/6jdMdIL++4A5EmsA3QZV0rsfxKIusqr2Z0Bpa82gGjTrJIdq2E7tBpJ/dDYf5
         tWSVromMcBwdux1QMYAqnnohWtWHHF1lzhgizAuh+khwBZOr8wfESPBorR1oHEqaXLxz
         vGjVMYSsP0OJdbg7azMzDf4xWBJF13gw42bIC7a7vYK+3ii5mJV0kUgCJ1xL6GVgP+pO
         33jA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of linux-kselftest-owner@vger.kernel.org designates 209.132.180.67 as permitted sender) smtp.mailfrom=linux-kselftest-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750877AbeCPVzf (ORCPT <rfc822;gregkh@linuxfoundation.org>);
        Fri, 16 Mar 2018 17:55:35 -0400
Received: from mga03.intel.com ([134.134.136.65]:25658 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750826AbeCPVzf (ORCPT <rfc822;linux-kselftest@vger.kernel.org>);
        Fri, 16 Mar 2018 17:55:35 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,317,1517904000";
   d="scan'208";a="25364983"
Subject: Re: [PATCH v12 02/22] selftests/vm: rename all references to pkru to
 a generic name
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
        linux-kselftest@vger.kernel.org
References: <1519264541-7621-1-git-send-email-linuxram@us.ibm.com>
 <1519264541-7621-3-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, x86@kernel.org, linux-arch@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        mingo@redhat.com, akpm@linux-foundation.org,
        benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, arnd@arndb.de
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <61350ceb-974f-6039-ae1e-f2626c405676@intel.com>
Date: Fri, 16 Mar 2018 14:55:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519264541-7621-3-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kselftest-owner@vger.kernel.org
X-Mailing-List: linux-kselftest@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593064386774181308?=
X-GMAIL-MSGID: =?utf-8?q?1595132961408253281?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/21/2018 05:55 PM, Ram Pai wrote:
>  int pkey_set(int pkey, unsigned long rights, unsigned long flags)
>  {
>  	u32 mask = (PKEY_DISABLE_ACCESS|PKEY_DISABLE_WRITE);
> -	u32 old_pkru = __rdpkru();
> -	u32 new_pkru;
> +	u32 old_pkey_reg = __rdpkey_reg();
> +	u32 new_pkey_reg;

If we're not using the _actual_ instruction names ("rdpkru"), I think
I'd rather this be something more readable, like: __read_pkey_reg().

But, it's OK-ish the way it is.

Reviewed-by: Dave Hansen <dave.hansen@intel.com>
