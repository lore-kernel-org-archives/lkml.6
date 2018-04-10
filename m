Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752248AbeDJG7m (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 02:59:42 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:41408 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751546AbeDJG7l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 02:59:41 -0400
Date: Tue, 10 Apr 2018 14:59:29 +0800
From: Dave Young <dyoung@redhat.com>
To: Philipp Rudo <prudo@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-s390@vger.kernel.org,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v2 00/11] kexec_file: Clean up purgatory load
Message-ID: <20180410065929.GA5592@dhcp-128-65.nay.redhat.com>
References: <20180321112751.22196-1-prudo@linux.vnet.ibm.com>
 <20180321160042.0f7d1fe21937f37af96a982a@linux-foundation.org>
 <20180323104116.0a3f00f4@ThinkPad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180323104116.0a3f00f4@ThinkPad>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/18 at 10:41am, Philipp Rudo wrote:
> Hi Andrew,
> Hi Dave,
> 
> i checked out linux-next with the patches and it looks good to me. Also made a
> quick test and everything works fine.

Thank you!  Not sure if it is late about an ack :)

Anyway, for the series:
Acked-by: Dave Young <dyoung@redhat.com>

Thanks
Dave
