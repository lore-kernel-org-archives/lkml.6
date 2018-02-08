Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751998AbeBHEHX (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 23:07:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:46860 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751796AbeBHEHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 23:07:21 -0500
Subject: Re: [PATCH] mm/migrate: Rename various page allocation helper
 functions
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20180204065816.6885-1-khandual@linux.vnet.ibm.com>
Cc: akpm@linux-foundation.org, mhocko@suse.com, hughd@google.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 8 Feb 2018 09:37:12 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <20180204065816.6885-1-khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
x-cbid: 18020804-0020-0000-0000-000003F379CC
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18020804-0021-0000-0000-00004285F651
Message-Id: <5458c2c9-3534-c00d-7abf-3315debbf896@linux.vnet.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2018-02-08_01:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1802080035
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/04/2018 12:28 PM, Anshuman Khandual wrote:
> Allocation helper functions for migrate_pages() remmain scattered with
> similar names making them really confusing. Rename these functions based
> on type of the intended migration. Function alloc_misplaced_dst_page()
> remains unchanged as its highly specialized. The renamed functions are
> listed below. Functionality of migration remains unchanged.
> 
> 1. alloc_migrate_target -> new_page_alloc
> 2. new_node_page -> new_page_alloc_othernode
> 3. new_page -> new_page_alloc_keepnode
> 4. alloc_new_node_page -> new_page_alloc_node
> 5. new_page -> new_page_alloc_mempolicy

Hello Michal/Hugh,

Does the renaming good enough or we should just not rename these.
