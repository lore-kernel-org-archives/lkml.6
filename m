Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932237AbeCLOkg (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 10:40:36 -0400
Received: from mout.web.de ([212.227.15.3]:40867 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751379AbeCLOkb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 10:40:31 -0400
Subject: Re: dmaengine: edma: Use common error handling code in three
 functions
From: SF Markus Elfring <elfring@users.sourceforge.net>
To: dmaengine@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Vinod Koul <vinod.koul@intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <cb8f32ef-14c1-35cb-39aa-d3efa265dccf@users.sourceforge.net>
Message-ID: <3c00002a-4d95-0caf-ef6f-68a2a094b8c0@users.sourceforge.net>
Date: Mon, 12 Mar 2018 15:40:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <cb8f32ef-14c1-35cb-39aa-d3efa265dccf@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:C3YEf+4GqCb6cuu8eNKyHpO2uFT7Jihm91L2sbIb807gsqxqFX3
 r+k9UEoobrXu8deGgHZXgMmOqLm5KngxvMUdseVIoyHpMigz+IoqgHX4i535L+6IiATtc4N
 EShBBwNrGDXSkijByufbG2e8Qpjp4glqxV4tdCz4/u6dfYiSr0/opvYG0b0mtHBy0slNLyu
 Y8RyLwQuVbUvAIKsllTdA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:YgaLyZ2jYoQ=:4X4ZO5ek74jretTmhpYByO
 JI5VDJSjFKKLwMBA34yaY2RC0N0oP7ci6eYeaa0pkuryWZI1zNC2TeOJ2qNlBhJxRTPorGsU9
 0L+KsD7sW1zRWdQqlBHuTjQtyFmFoz7tsL3EgEdbdF2Y/GZZ5PxgGjWcUqmrbIlzqh4nZx8SZ
 tr01m7n2M2AFN7lXkxbcRhU87Y/x4Ft11bqna9L2uD7J8S9qWxMpTt1XBYFMdKP2WGoXdACvD
 PA9sJ0Zpc3LThPSQmdwtRzTz7aSSUN/aNITLfVNVJD7Wi9JzR3b6KzthNkznqhfOtKGz3TDa7
 E/gA6hYNRE7nhhHieYZ4YhwuLgSh7TLb9omiX73C6TTPctKhKpkMmiWgFyoISR1DBohGDjMuI
 Le9fSaTq2D5fPTU9vPOjr9NZ5+q0bEZBls83Jdt++fK8gvziKVsc4EmXwAAY5X0sRoTy5d1gf
 X4+UbIYfJGeLovec6ZO6qw5cKeFsOYm8hhZ2Xnkh3wWtFvpxzVnD9639ixSXlXMjfMqwpYLKj
 qwix555sonIB/ZjrvSYDwnc2DpWwVMAt0c9hJja2KgMYytg44JHiiDUPAG/HG/CBvqMI7RpVJ
 wC3p6FsM4t7rMHlsOEgQexldk4hPMYTOiX0d0u2W2f1mNEQ7oCit2qLcdayp2XgyxxxgeWyZ0
 T2ERPEjBcChFzLWZuoKi4GW8mvYpKfYDAAtLkFnUaMv1dUjRdenw1fOiwIBcSPF49PJiOq8Ah
 Vt4rZerWVaKePqPtObW0DpV6jvsMcxxrxJA0cy7MyMvuTwp0bOMqZn7s87sQUQ29N5DrpVJeJ
 dr/n5rr77ROFWLIIA2y5GBV6aJohTfUF+zuUbXOobYnUx8GxRs=
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Date: Sun, 22 Oct 2017 16:46:34 +0200
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of these functions.

How are the chances to integrate such a change into another Linux repository?
https://lkml.org/lkml/2017/10/22/78
https://patchwork.kernel.org/patch/10021725/
https://lkml.kernel.org/r/<cb8f32ef-14c1-35cb-39aa-d3efa265dccf@users.sourceforge.net>

Regards,
Markus
