Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932963AbeEWNOv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 09:14:51 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:45126 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932845AbeEWNOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 09:14:49 -0400
X-Google-Smtp-Source: AB8JxZrRDgxmzeRKUVULMjD4cIpyRhDEovzoDJR9DREKe0ni4moSTwinEREzu3NLeyukuN7hnzhsvAK0l4Mgs7Z0Qbo=
MIME-Version: 1.0
References: <20180523125555.30039-1-mhocko@kernel.org> <20180523125555.30039-2-mhocko@kernel.org>
In-Reply-To: <20180523125555.30039-2-mhocko@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Date: Wed, 23 May 2018 09:14:08 -0400
X-Gmail-Original-Message-ID: <CAGM2reYGN+yrDP_cUY1rPOpy7owdvQLqfrYqF9YSDPKdJOGEeg@mail.gmail.com>
Message-ID: <CAGM2reYGN+yrDP_cUY1rPOpy7owdvQLqfrYqF9YSDPKdJOGEeg@mail.gmail.com>
Subject: Re: [PATCH 1/2] mm, memory_hotplug: make has_unmovable_pages more robust
To: mhocko@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
        osalvador@techadventures.net, Vlastimil Babka <vbabka@suse.cz>,
        arbab@linux.vnet.ibm.com, imammedo@redhat.com, vkuznets@redhat.com,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Michal Hocko <mhocko@suse.com>
Content-Type: text/plain; charset="UTF-8"
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8901 signatures=668700
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=484
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805230135
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Pavel Tatashin <pasha.tatashin@oracle.com>
