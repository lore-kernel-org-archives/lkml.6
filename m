Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752135AbeAaHHR (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 02:07:17 -0500
Received: from mail-wm0-f67.google.com ([74.125.82.67]:55734 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751001AbeAaHHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 02:07:15 -0500
X-Google-Smtp-Source: AH8x224fIpOdmoEFPo+dmPiI/fR0IEnPfjGV7UzY9qB4fcPICoqo7j+J58jvMd7XR3gHxyxV+7ofsA==
Date: Wed, 31 Jan 2018 08:07:11 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, mingo@redhat.com, akpm@linux-foundation.org,
        linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, benh@kernel.crashing.org, paulus@samba.org,
        khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
        bsingharora@gmail.com, hbabu@us.ibm.com, mhocko@kernel.org,
        bauerman@linux.vnet.ibm.com, ebiederm@xmission.com, corbet@lwn.net,
        arnd@arndb.de, fweimer@redhat.com, msuchanek@suse.com
Subject: Re: [PATCH v11 0/3] mm, x86, powerpc: Enhancements to Memory
 Protection Keys.
Message-ID: <20180131070711.pad45qmnougnh4vf@gmail.com>
References: <1517341452-11924-1-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517341452-11924-1-git-send-email-linuxram@us.ibm.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ram Pai <linuxram@us.ibm.com> wrote:

> This patch series provides arch-neutral enhancements to
> enable memory-keys on new architecutes, and the corresponding
> changes in x86 and powerpc specific code to support that.
> 
> a) Provides ability to support upto 32 keys.  PowerPC
> 	can handle 32 keys and hence needs this.
> 
> b) Arch-neutral code; and not the arch-specific code,
>    determines the format of the string, that displays the key
>    for each vma in smaps.
> 
> PowerPC implementation of memory-keys is now in powerpc/next tree.
> https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=next&id=92e3da3cf193fd27996909956c12a23c0333da44

All three patches look sane to me. If you would like to carry these generic bits 
in the PowerPC tree as well then:

  Reviewed-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
