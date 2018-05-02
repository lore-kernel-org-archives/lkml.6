Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751687AbeEBPiB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 11:38:01 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33802 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750936AbeEBPh7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 11:37:59 -0400
Subject: Re: linux-next: Tree for May 2 (objtool bug!)
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
References: <20180502165939.2375cf6a@canb.auug.org.au>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <fb41f3ee-705e-4886-3f78-c7f88db5276d@infradead.org>
Date: Wed, 2 May 2018 08:37:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180502165939.2375cf6a@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2018 11:59 PM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20180501:
> 

on x86_64 randconfig:

  CC      fs/cifs/smbencrypt.o
drivers/char/ipmi/ipmi_ssif.o: warning: objtool: return_hosed_msg()+0x0: infinite recursion (objtool bug!)
drivers/char/ipmi/ipmi_ssif.o: warning: objtool: deliver_recv_msg()+0x0: infinite recursion (objtool bug!)



-- 
~Randy
