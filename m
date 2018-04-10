Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbeDJQVy (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 12:21:54 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:54500 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752181AbeDJQVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 12:21:52 -0400
Date: Tue, 10 Apr 2018 12:21:36 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Bonzini <pbonzini@redhat.com>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org
Subject: Re: [PATCH v3] X86/VMX: Disable VMX preemption timer if MWAIT is not
 intercepted
Message-ID: <20180410162136.GA6602@char.us.oracle.com>
References: <1523362546-20909-1-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523362546-20909-1-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8858 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=587
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1804100157
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 02:15:46PM +0200, KarimAllah Ahmed wrote:
> The VMX-preemption timer is used by KVM as a way to set deadlines for the
> guest (i.e. timer emulation). That was safe till very recently when
> capability KVM_X86_DISABLE_EXITS_MWAIT to disable intercepting MWAIT was
> introduced. According to Intel SDM 25.5.1:

Would it make sense to remove the '25.5.1' and just have the chapter name, etc
as those do move around?
