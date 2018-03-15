Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeCORSC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 13:18:02 -0400
Received: from merlin.infradead.org ([205.233.59.134]:57098 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750987AbeCORSA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 13:18:00 -0400
Subject: Re: mmotm 2018-03-14-16-24 uploaded (lustre)
To: akpm@linux-foundation.org, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        lustre-devel@lists.lustre.org
References: <20180314232442.rL_lhWQqT%akpm@linux-foundation.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <5c65e935-a6d9-2f80-18ac-470ed38ba439@infradead.org>
Date: Thu, 15 Mar 2018 10:17:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314232442.rL_lhWQqT%akpm@linux-foundation.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/14/2018 04:24 PM, akpm@linux-foundation.org wrote:
> The mm-of-the-moment snapshot 2018-03-14-16-24 has been uploaded to
> 
>    http://www.ozlabs.org/~akpm/mmotm/

(not from the mmotm patches, but in its linux-next.patch)

CONFIG_LUSTRE_FS=y
# CONFIG_LUSTRE_DEBUG_EXPENSIVE_CHECK is not set


In file included from ../drivers/staging/lustre/include/linux/libcfs/libcfs.h:42:0,
                 from ../drivers/staging/lustre/lustre/obdclass/lu_object.c:44:
../drivers/staging/lustre/lustre/obdclass/lu_object.c: In function 'lu_context_key_degister':
../drivers/staging/lustre/lustre/obdclass/lu_object.c:1410:51: error: dereferencing pointer to incomplete type
          __func__, key->lct_owner ? key->lct_owner->name : "",
                                                   ^
../drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h:123:41: note: in definition of macro '__CDEBUG'
   libcfs_debug_msg(&msgdata, format, ## __VA_ARGS__); \
                                         ^
../drivers/staging/lustre/lustre/obdclass/lu_object.c:1409:3: note: in expansion of macro 'CDEBUG'
   CDEBUG(D_INFO, "%s: \"%s\" %p, %d\n",
   ^
../drivers/staging/lustre/lustre/obdclass/lu_object.c: In function 'lu_context_key_quiesce':
../drivers/staging/lustre/lustre/obdclass/lu_object.c:1550:42: error: dereferencing pointer to incomplete type
           key->lct_owner ? key->lct_owner->name : "",
                                          ^
../drivers/staging/lustre/include/linux/libcfs/libcfs_debug.h:123:41: note: in definition of macro '__CDEBUG'
   libcfs_debug_msg(&msgdata, format, ## __VA_ARGS__); \
                                         ^
../drivers/staging/lustre/lustre/obdclass/lu_object.c:1548:4: note: in expansion of macro 'CDEBUG'
    CDEBUG(D_INFO, "%s: \"%s\" %p, %d (%d)\n",
    ^



-- 
~Randy
