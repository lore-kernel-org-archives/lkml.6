Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeBSDoP (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 22:44:15 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:39284 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751962AbeBSDoN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 22:44:13 -0500
X-Google-Smtp-Source: AH8x224nGz2yFBTcF4lUaBqsJevvAjvrUTQeBewtis/9Ce2TCxybcpxr656E+bFmp95neDCoEo+XGg==
Date: Mon, 19 Feb 2018 09:14:10 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] cpufreq: powernow-k8: Delete an error message for a
 failed memory allocation in three functions
Message-ID: <20180219034410.GJ28462@vireshk-i7>
References: <4dd36236-fc39-19e6-c1a7-a094cf13469c@users.sourceforge.net>
 <895a6088-5266-0be7-90f6-b1f838eb58c1@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <895a6088-5266-0be7-90f6-b1f838eb58c1@users.sourceforge.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15-02-18, 20:29, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 15 Feb 2018 20:00:23 +0100
> 
> Omit an extra message for a memory allocation failure in these functions.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  drivers/cpufreq/powernow-k8.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
