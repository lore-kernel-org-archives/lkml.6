Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752223AbeEQPlW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 11:41:22 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45224 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751564AbeEQPlV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 11:41:21 -0400
Date: Thu, 17 May 2018 08:40:55 -0700
From: Larry Bassel <larry.bassel@oracle.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC] mm, THP: Map read-only text segments using large THP pages
Message-ID: <20180517154055.GB6951@ubuette>
References: <5BB682E1-DD52-4AA9-83E9-DEF091E0C709@oracle.com>
 <20180517152333.GA26718@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517152333.GA26718@bombadil.infradead.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=8896 signatures=668698
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=850
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1711220000 definitions=main-1805170145
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 May 18 08:23, Matthew Wilcox wrote:
> 
> I can't find any information on what page sizes SPARC supports.
> Maybe you could point me at a reference?  All I've managed to find is
> the architecture manuals for SPARC which believe it is not their purpose
> to mandate an MMU.
> 

Page sizes of 8K, 64K, 512K, 4M, 32M, 256M, 2G, 16G are allowed
architecturally -- some of these aren't present in some
SPARC machines. Generally 8K, 64K, 4M, 256M, 2G, 16G are
present on modern machines. 

Also note that the SPARC THP page size is 8M (so that it is
PMD aligned).

Larry
