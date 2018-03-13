Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932394AbeCMPY0 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 11:24:26 -0400
Received: from omr-m001e.mx.aol.com ([204.29.186.1]:35019 "EHLO
        omr-m001e.mx.aol.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751961AbeCMPYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 11:24:24 -0400
Subject: Re: [PATCH] perf annotate: Don't prepend symfs path to
 build_id_filename
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180211191937.9703-1-jpmv27@aim.com>
 <20180309190715.GB25111@kernel.org>
From: Martin Vuille <jpmv27@aim.com>
Message-ID: <e036d7fc-7787-3005-93f5-19ebfa339882@aim.com>
Date: Tue, 13 Mar 2018 11:24:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180309190715.GB25111@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
x-aol-global-disposition: G
x-aol-sid: 3039ac1add4e5aa7ed26691c
X-AOL-IP: 99.246.128.134
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/09/18 14:07, Arnaldo Carvalho de Melo wrote:
> Em Sun, Feb 11, 2018 at 02:19:37PM -0500, Martin Vuille escreveu:
>> build_id_filename already contains symfs path if applicable, so
>> don't prepend it a second time.
> Where is the analysis that shows that that is the case? I looked here at
> the implementation for dso__build_id_filename() and couldn't find where
> was it that the symfs would be appended, can you clarify?
>
> - Arnaldo
>   
Patch resubmitted with additional details in commit message:

https://patchwork.kernel.org/patch/10279077/

Regards,
MV
