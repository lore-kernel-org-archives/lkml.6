Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753844AbeERIbM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 04:31:12 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:35712 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753084AbeERIbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 04:31:08 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Fri, 18 May 2018 01:31:05 -0700
From: skannan@codeaurora.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Rajendra Nayak <rjendra@codeaurora.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        rjwysocki@gmail.com
Subject: Re: [PATCH 1/2] Revert "cpufreq: Remove policy create/remove
 notifiers"
In-Reply-To: <CAJZ5v0geHvVUfL=+x-XNMQt4ygpt8QumOaWSjG268Sbtw9oeKw@mail.gmail.com>
References: <1526631889-5084-1-git-send-email-skannan@codeaurora.org>
 <1526631889-5084-2-git-send-email-skannan@codeaurora.org>
 <CAJZ5v0geHvVUfL=+x-XNMQt4ygpt8QumOaWSjG268Sbtw9oeKw@mail.gmail.com>
Message-ID: <1a66e15a401b2e1602f26cff5e904f12@codeaurora.org>
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018-05-18 01:29, Rafael J. Wysocki wrote:
> On Fri, May 18, 2018 at 10:24 AM, Saravana Kannan
> <skannan@codeaurora.org> wrote:
>> This reverts commit f9f41e3ef99ac9d4e91b07634362e393fb929aad.
> 
> No explanation, no cake. :-)
> 
>> Change-Id: Iddde3ef56c9e5b14dcb14f8737899b85e56f5b43
> 
> S-o-b missing.

Sorry, forgot the S-o-b. But there's a long explanation in the cover 
letter :)

-Saravana
