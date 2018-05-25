Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030281AbeEYUyN (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 16:54:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39866 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S968275AbeEYUyL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 16:54:11 -0400
Date: Fri, 25 May 2018 14:54:08 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
Cc: "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "pmorel@linux.vnet.ibm.com" <pmorel@linux.vnet.ibm.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        Linuxarm <linuxarm@huawei.com>, "John Garry" <john.garry@huawei.com>,
        "xuwei (O)" <xuwei5@huawei.com>, Joerg Roedel <joro@8bytes.org>
Subject: Re: [PATCH v6 0/7] vfio/type1: Add support for valid iova list
 management
Message-ID: <20180525145408.2938a9ec@w520.home>
In-Reply-To: <5FC3163CFD30C246ABAA99954A238FA8386EE591@FRAEML521-MBX.china.huawei.com>
References: <20180418114045.7968-1-shameerali.kolothum.thodi@huawei.com>
        <20180524122032.724676b9@w520.home>
        <5FC3163CFD30C246ABAA99954A238FA8386EE591@FRAEML521-MBX.china.huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 25 May 2018 08:45:36 +0000
Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com> wrote:

> Yes, the above changes related to list empty cases looks fine to me. 

Thanks Shameer, applied to my next branch with the discussed fixes for
v4.18 (modulo patch 4/7 which Joerg already pushed for v4.17).  Thanks,

Alex
