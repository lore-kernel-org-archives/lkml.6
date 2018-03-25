Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752328AbeCYWMr (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Mar 2018 18:12:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:57867 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751091AbeCYWMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Mar 2018 18:12:30 -0400
Subject: Re: [PATCH v3 2/2] x86, cpuid: allow cpuid_read() to schedule
To: Eric Dumazet <eric.dumazet@gmail.com>,
        Eric Dumazet <edumazet@google.com>, x86 <x86@kernel.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@redhat.com>, Hugh Dickins <hughd@google.com>
References: <20180323215818.127774-1-edumazet@google.com>
 <20180323215818.127774-2-edumazet@google.com>
 <3622b64c-bae6-00db-6a61-3ccf760144aa@zytor.com>
 <df40ad66-8bab-67ca-bce7-b82f09083f2e@gmail.com>
From: "H. Peter Anvin" <hpa@zytor.com>
Message-ID: <d88d3e92-e9af-5ffd-9b9e-731255226f99@zytor.com>
Date: Sun, 25 Mar 2018 15:11:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <df40ad66-8bab-67ca-bce7-b82f09083f2e@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/23/18 18:01, Eric Dumazet wrote:
> 
> Indeed, assuming a daemon can have threads running on all cpus :/
> 
> Some environments like to partition cpus for different jobs/containers.
> 

Then it doesn't need to run it on all cpus... just the one that that
particular daemon is "responsible" for.

	-hpa
