Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752232AbeBWVoc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 23 Feb 2018 16:44:32 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:33652 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751455AbeBWVoa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Feb 2018 16:44:30 -0500
Date: Fri, 23 Feb 2018 16:36:02 -0500
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To: KarimAllah Ahmed <karahmed@amazon.de>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        hpa@zytor.com, jmattson@google.com, mingo@redhat.com,
        pbonzini@redhat.com, rkrcmar@redhat.com, tglx@linutronix.de
Subject: Re: [PATCH 05/10] KVM/nVMX: Use kvm_vcpu_map when mapping the L1 MSR
 bitmap
Message-ID: <20180223213602.GG20992@char.us.oracle.com>
References: <1519235241-6500-1-git-send-email-karahmed@amazon.de>
 <1519235241-6500-6-git-send-email-karahmed@amazon.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519235241-6500-6-git-send-email-karahmed@amazon.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8813 signatures=668678
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=689
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1802230265
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 06:47:16PM +0100, KarimAllah Ahmed wrote:
> ... since using kvm_vcpu_gpa_to_page() and kmap() will only work for guest
> memory that has a "struct page".
> 
> The life-cycle of the mapping also changes to avoid doing map and unmap on

s/also changes/has been changed/ ?
