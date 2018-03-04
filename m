Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752174AbeCDV14 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Mar 2018 16:27:56 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:41003 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752018AbeCDV1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Mar 2018 16:27:54 -0500
X-Google-Smtp-Source: AG47ELsXYambo0YTUGGovfgbXAzIyLQzmvKXFKvF1zmOO8d8+dW9p2Z+8j8Biv8sJTwk0V+H/U7yBsKi4Sy+5a76ppQ=
MIME-Version: 1.0
In-Reply-To: <20180304173132.19677-1-vaibhav@linux.vnet.ibm.com>
References: <20180304173132.19677-1-vaibhav@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 5 Mar 2018 08:27:52 +1100
Message-ID: <CAKTCnznOU=8W2up5PQFRQHbmCZvht_8Vmt5F_gb1yaZEKQDTWw@mail.gmail.com>
Subject: Re: [PATCH] xmon: Clear all breakpoints when xmon is disabled via debugfs
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
        Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
        <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
        Douglas Miller <dougmill@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 5, 2018 at 4:31 AM, Vaibhav Jain <vaibhav@linux.vnet.ibm.com> wrote:
> Presently when xmon is disabled by debugfs any existing
> instruction/data-access breakpoints set are not disabled. This may
> lead to kernel oops when those breakpoints are hit as the necessary
> debugger hooks aren't installed.
>
> Hence this patch introduces a new function named clear_all_bpt()
> which is called when xmon is disabled via debugfs. The function will
> unpatch/clear all the trap and ciabr/dab based breakpoints.
>
> Signed-off-by: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
> ---

Reviewed-by: Balbir Singh <bsingharora@gmail.com>

Balbir
