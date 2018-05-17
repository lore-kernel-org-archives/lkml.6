Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbeEQXjd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 19:39:33 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:44017 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750924AbeEQXjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 19:39:31 -0400
X-Google-Smtp-Source: AB8JxZoGgPIpWaHN3ToHDGJQW5LO6Wk8RsZIgPKIb6FxgFqmDV8SwqGEP00Tj2zS7pjq7vXJEE+ZQA==
Date: Thu, 17 May 2018 16:39:23 -0700
From: Stephen Hemminger <stephen@networkplumber.org>
To: Michael Kelley <mhkelley58@gmail.com>
Cc: mikelley@microsoft.com, kys@microsoft.com, sthemmin@microsoft.com,
        martin.petersen@oracle.com, longli@microsoft.com,
        jejb@linux.vnet.ibm.com, devel@linuxdriverproject.org,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH 1/1] scsi: storvsc: Avoid allocating memory for temp
 cpumasks
Message-ID: <20180517163923.022c0536@xeon-e3>
In-Reply-To: <1526591260-27162-1-git-send-email-mikelley@microsoft.com>
References: <1526591260-27162-1-git-send-email-mikelley@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 May 2018 14:07:40 -0700
Michael Kelley <mhkelley58@gmail.com> wrote:

> Current code allocates 240 Kbytes (in typical configs) for
> each synthetic SCSI controller to use as temp cpumask variables.
> Recode to avoid needing the temp cpumask variables and remove the
> memory allocation.
> 
> Signed-off-by: Michael Kelley <mikelley@microsoft.com>

Acked-by: Stephen Hemminger <sthemmin@microsoft.com>
