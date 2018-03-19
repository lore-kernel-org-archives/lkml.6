Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755625AbeCSPJv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Mar 2018 11:09:51 -0400
Received: from mx2.suse.de ([195.135.220.15]:39788 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1755226AbeCSPJs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Mar 2018 11:09:48 -0400
Subject: Re: [PATCH] x86/vsyscall/64: Use proper accessor to update p4d entry
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, luto@kernel.org,
        x86@kernel.org
References: <20180319143154.3742-1-boris.ostrovsky@oracle.com>
From: Juergen Gross <jgross@suse.com>
Message-ID: <9203a154-3b96-7c57-7be5-2ddc81191ca0@suse.com>
Date: Mon, 19 Mar 2018 16:09:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180319143154.3742-1-boris.ostrovsky@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/03/18 15:31, Boris Ostrovsky wrote:
> Writing to it directly does not work for Xen PV guests.
> 
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Reviewed-by: Juergen Gross <jgross@suse.com>


Juergen
