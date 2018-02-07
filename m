Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754368AbeBGOzv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 09:55:51 -0500
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:47118 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754065AbeBGOzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 09:55:49 -0500
Date: Wed, 7 Feb 2018 08:55:47 -0600 (CST)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@nuc-kabylake
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
cc: Kirill Tkhai <ktkhai@virtuozzo.com>, josh@joshtriplett.org,
        rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
        jiangshanlai@gmail.com, mingo@redhat.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, akpm@linux-foundation.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org, brouer@redhat.com,
        rao.shoaib@oracle.com
Subject: Re: [PATCH 0/2] rcu: Transform kfree_rcu() into kvfree_rcu()
In-Reply-To: <20180207021703.GC3617@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1802070854080.21329@nuc-kabylake>
References: <151791170164.5994.8253310844733420079.stgit@localhost.localdomain> <20180207021703.GC3617@linux.vnet.ibm.com>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-CMAE-Envelope: MS4wfE0On2jR36NT55WiWuoVNGEc9NWPqC7qPMdDNPovqpNZO2GHagaUHizVn/pcoWX/tKn49Xaa9fT2tapaIBGcv5OiCwjTDHbWBITmrjPXZPA9aov7ka5Y
 EhLRG1AHMwwpq1g3786Ft0raVKVlM/WJP9VkO6CMRMoLgkWRRX9txx/9TK8b1XJxSe+kes212Ye+kx4DuekOn+42Lh8QhgRl7lUS0HvLNGW9g202x8pglYxB
 u5JtbKge3s35GmtTOcMtacsGL5e25JGKFpQtaCvrZZPeR6IIuQiS9HBrMEnXSOwS9l/UkuGX6WlsdDuV2/aLAu2trpgfQzkMGygdOSMcK1rZIdeiVs/dWbGY
 FZ7lfEAOvTHi7/VC8WDhmMSwUh0VfljKpVZ4u+hCCPs2eImozM3yeONcb+MJYgJSnk3Z6bte4Nm0LOaD85TJOifmeHbSAj+OLcID7Vc2VRtcJ7rSUVsKKQzb
 5s95E568JzET7oprvHJthMkuPep8FW9gvD1u/AL7Gr38rtAetC1v0ZL6o9bE+8uTuCPgo+RutLkNAKTUhtcoemSK2eulEktJfl4yrZOgGmQ2sW2mtBRfZhFN
 yY12TXKoTLb3E2dLrrozP85JixYnJGU/iKQ4xr7Sr8jUiA==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Feb 2018, Paul E. McKenney wrote:

> So it is OK to kvmalloc() something and pass it to either kfree() or
> kvfree(), and it had better be OK to kvmalloc() something and pass it
> to kvfree().

kvfree() is fine but not kfree().
