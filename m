Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750876AbeEaW3G (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 18:29:06 -0400
Received: from lelnx194.ext.ti.com ([198.47.27.80]:30247 "EHLO
        lelnx194.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750737AbeEaW3F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 18:29:05 -0400
Subject: Re: [PATCH v2 0/2] ti-cpufreq: minor fixes/cleanups
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
CC: Viresh Kumar <viresh.kumar@linaro.org>,
        Dave Gerlach <d-gerlach@ti.com>, Tero Kristo <t-kristo@ti.com>,
        <linux-omap@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180402164958.20057-1-s-anna@ti.com>
 <ffbb49c3-229b-df20-ca0d-c49822fcdaf2@ti.com>
 <2808028.7H1yeuone6@aspire.rjw.lan>
From: Suman Anna <s-anna@ti.com>
Message-ID: <c49fce73-ae82-2074-8d9c-c7019fa8fdb4@ti.com>
Date: Thu, 31 May 2018 17:29:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <2808028.7H1yeuone6@aspire.rjw.lan>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael,

On 05/18/2018 03:19 PM, Rafael J. Wysocki wrote:
> On Friday, May 18, 2018 5:07:12 PM CEST Suman Anna wrote:
>> On 04/02/2018 11:49 AM, Suman Anna wrote:
>>> Hi Viresh,
>>>
>>> Please find the updated series replacing the previous patch [1] fixing
>>> couple of issues in the TI CPUFreq driver. I have split up the patches
>>> as per your comments on v1. Final code diff remains the same as before.
>>>
>>> regards
>>> Suman
>>>
>>> [1] https://patchwork.kernel.org/patch/10308925/
>>>
>>> Suman Anna (2):
>>>   cpufreq: ti-cpufreq: Fix an incorrect error return value
>>>   cpufreq: ti-cpufreq: Use devres managed API in probe()
>>
>> Gentle reminder, I don't see these patches in -next. Who is picking up
>> these patches?
> 
> You need to resend them I'm afraid, with any tags received so far.
> 
> And they won't be picked up if you don't CC linux-pm@vger.kernel.org on
> the submission.

Sorry for the delay, I have reposted the series with all the tags picked
up and CCing the linux-pm list.

regards
Suman
