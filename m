Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752134AbeCCPbw (ORCPT <rfc822;w@1wt.eu>);
        Sat, 3 Mar 2018 10:31:52 -0500
Received: from mga01.intel.com ([192.55.52.88]:56393 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752095AbeCCPbv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Mar 2018 10:31:51 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,418,1515484800";
   d="scan'208";a="21612489"
Subject: Re: [PATCH 2/2] IB/qib: Move char *qib_sdma_state_names[] and
 constify while there.
To: =?UTF-8?Q?Hern=c3=a1n_Gonzalez?= <hernan@vanguardiasur.com.ar>,
        mike.marciniszyn@intel.com, dledford@redhat.com, jgg@ziepe.ca,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1519769143-20000-1-git-send-email-hernan@vanguardiasur.com.ar>
 <1519769143-20000-2-git-send-email-hernan@vanguardiasur.com.ar>
From: Dennis Dalessandro <dennis.dalessandro@intel.com>
Message-ID: <ce0ddb85-e008-9895-6508-7d721edeb1de@intel.com>
Date: Sat, 3 Mar 2018 10:31:48 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1519769143-20000-2-git-send-email-hernan@vanguardiasur.com.ar>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/2018 5:05 PM, Hernán Gonzalez wrote:
> Note: This is compile only tested as I have no access to the hw.
> This variable was not used in qib_sdma.c but in qib_iba7322.c. Declaring it
> there, as static, saves 56 bytes.
> 
> add/remove: 0/2 grow/shrink: 0/0 up/down: 0/-144 (-144)
> Function                                     old     new   delta
> qib_sdma_state_names                          56       -     -56
> qib_sdma_event_names                          88       -     -88
> Total: Before=2874565, After=2874421, chg -0.01%
> 
> Signed-off-by: Hernán Gonzalez <hernan@vanguardiasur.com.ar>

Looks OK to me, thanks.

Reviewed-by: Dennis Dalessandro <dennis.dalessandro@intel.com>
