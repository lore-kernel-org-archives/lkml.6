Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755371AbeEHOPH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 8 May 2018 10:15:07 -0400
Received: from mga11.intel.com ([192.55.52.93]:22312 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752252AbeEHOPG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 May 2018 10:15:06 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,378,1520924400";
   d="scan'208";a="47651433"
Subject: Re: Problem with global pages changeset and kvm
To: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-kernel@vger.kernel.org
References: <20180508093723.GA4529@calabresa>
From: Dave Hansen <dave.hansen@linux.intel.com>
Openpgp: preference=signencrypt
Message-ID: <137272d9-9c30-3b28-0903-07add5e2036b@linux.intel.com>
Date: Tue, 8 May 2018 07:15:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180508093723.GA4529@calabresa>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the excellent bug report!

On 05/08/2018 02:37 AM, Thadeu Lima de Souza Cascardo wrote:
> 2) The bad address is next to do_syscall_64 on the host.

So a host address leaked into a guest oops?

We should bring the KVM folks into this and probably also need to widen
the cc list quite a bit.

Can you boot the guest at all?
