Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966319AbeCAGYe (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 01:24:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:46142 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S966268AbeCAGYd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 01:24:33 -0500
Subject: Re: [PATCH v2] pvcalls-front: 64-bit align flags
To: Stefano Stabellini <sstabellini@kernel.org>,
        boris.ostrovsky@oracle.com
Cc: xen-devel@lists.xenproject.org, linux-kernel@vger.kernel.org
References: <alpine.DEB.2.10.1802281803430.4239@sstabellini-ThinkPad-X260>
From: Juergen Gross <jgross@suse.com>
Message-ID: <d00f0026-8801-2cc1-e90d-054533e5ba73@suse.com>
Date: Thu, 1 Mar 2018 07:24:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.10.1802281803430.4239@sstabellini-ThinkPad-X260>
Content-Type: text/plain; charset=utf-8
Content-Language: de-DE
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/18 03:05, Stefano Stabellini wrote:
> We are using test_and_* operations on the status and flag fields of
> struct sock_mapping. However, these functions require the operand to be
> 64-bit aligned on arm64. Currently, only status is 64-bit aligned.
> 
> Make status and flags explicitly 64-bit aligned.
> 
> Signed-off-by: Stefano Stabellini <stefano@aporeto.com>

Committed to xen/tip for-linus-4.16a


Juergen
