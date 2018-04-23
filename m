Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755261AbeDWNYE (ORCPT <rfc822;w@1wt.eu>);
        Mon, 23 Apr 2018 09:24:04 -0400
Received: from upbd19pa07.eemsg.mail.mil ([214.24.27.82]:13867 "EHLO
        upbd19pa07.eemsg.mail.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754802AbeDWNYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Apr 2018 09:24:00 -0400
X-IronPort-AV: E=Sophos;i="5.49,318,1520899200";
   d="scan'208";a="12365612"
IronPort-PHdr: =?us-ascii?q?9a23=3AHCQZ6x0xkWNkU5cMsmDT+DRfVm0co7zxezQtwd?=
 =?us-ascii?q?8ZsesVK/jxwZ3uMQTl6Ol3ixeRBMOHs6kC07KempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffwtFiCChbb9uMR67sRjfus4KjIV4N60/0A?=
 =?us-ascii?q?HJonxGe+RXwWNnO1eelAvi68mz4ZBu7T1et+ou+MBcX6r6eb84TaFDAzQ9L2?=
 =?us-ascii?q?81/szrugLdQgaJ+3ART38ZkhtMAwjC8RH6QpL8uTb0u+ZhxCWXO9D9QKsqUj?=
 =?us-ascii?q?q+8ahkVB7oiD8GNzEn9mHXltdwh79frB64uhBz35LYbISTOfVwZKPdec4RS3?=
 =?us-ascii?q?RHUMhfSidNBpqwY5UTA+YEO+tTsovzqEYUrRamGAeiGu3vxD9LiHH406I13O?=
 =?us-ascii?q?YuHh3J0gE7A9IDsm7ZoMnpOKocU+24yrTDwzXZb/NR3Dfw8JXGcgw/rvGUXb?=
 =?us-ascii?q?J/b8zRwlQyGQPAlFqQrYjlMC2V1+8QtGWb9PdvVfm0hm47qwB+vjivxsA2ho?=
 =?us-ascii?q?nPnYIa0ErI9Sp+wIYrPNC1TlNwb928EJZIqi2XOIR7TtkiTm11oio21LILtY?=
 =?us-ascii?q?ChcCQXzpks2gTRZOadc4eS5xLuTOORITBli317YL+/nBOy8VS4yu37S8m0zE?=
 =?us-ascii?q?5GripbndnIsXAAzwDT5dKdSvt840ehwiyD1xzT6+5YIUA0krDXK5g9zb4rip?=
 =?us-ascii?q?Ufq0HDHi7ymEnuja+WcFsr+vSw5uj6bbjrqYWQOo9phg3kLKgjldKzDf4lPg?=
 =?us-ascii?q?QWWmiU4+W81Lnt/U3jR7VKi+U7krLEv5DBPskbuq64DBNV0oYk8Rq/CSym38?=
 =?us-ascii?q?4CkXkIK1JFZgqLj5L1NFHWPPD4EfC/jkyxnzdrwPDHMKPuApHJLnjYi7rhZ6?=
 =?us-ascii?q?hy5FNcyAUp0dBT/Y5bCrYEIPjrQE/+qMTYDgMlMwyz2+vnEM9y1p4aWW+UGq?=
 =?us-ascii?q?+WKr7SsVuR6uIqJOmMY5UVtyjnJ/c54P7uiGczmUUBcqmxwZsXdHe4E+x4I0?=
 =?us-ascii?q?WYe3rshcwMEGYUsQo4TezqlkeOUTpSZ3a0QqI96Ss3CIW8DYfMXIytnb+B1j?=
 =?us-ascii?q?+hHpJKfmBGFkyMEXDweoWAWvcMbj+SI8B4njwCW7ihUJQs1Q+htADk0bprNO?=
 =?us-ascii?q?nU9TMCtZLlytd14/fflRYo9Tx7F86dyX2CT3lonmMUQD87xKR/oU17ylee3q?=
 =?us-ascii?q?l0mv9YGsJJ5/NPTAg6MYXRz/J1C9/sQALNZNSJR0i8QtWgHz4xSsg9w9gUY0?=
 =?us-ascii?q?ZyA9+ilAzM3zK2A78JkLyGHJg08qPa33jsKMdx0m3G27c9gFk7WMtPNHGmh6?=
 =?us-ascii?q?5m+wjWAI7GjliZl6K0eqkHwi7N+3mMzXCUsEFbTgFwS6PFUm4bZkfMqtT5/E?=
 =?us-ascii?q?zCRae0Cbs7KgtB1dKCKqxSZ93tjFVGQurjOdvHb2K/gGe/GAiHxq2SY4ruYG?=
 =?us-ascii?q?gdwirdB1YekwwJ/naJKxI+BiG/rGLaFjBuEkjvY0z0++lktHy7VlM0zx2Nb0?=
 =?us-ascii?q?B507q1+xgVheGTSv8KxL0Etjwhpi5wHFa8xNLWF8GAqxBgfKVab9M9+k1I2n?=
 =?us-ascii?q?/HuANnI5OsNadihkQRc1c/g0S7+xxpC4kIsc81oXcu10ImJaKfz15Fcyiwx5?=
 =?us-ascii?q?38OrTLbGL1+UbrI5bfx1WW9dGR4KpHvOwxtlHLpAi0Eg8n9HJ93p9e1H7Ktb?=
 =?us-ascii?q?vQCw9Hao78SkY68VBBorjeZiQsr9fP2WZELbi/sjiE3ckgQuQi1EDzLJ9kLK?=
 =?us-ascii?q?qYGVqqQIUhDM+0JblvwgLxYw=3D=3D?=
X-IPAS-Result: =?us-ascii?q?A2AXCABx3d1a/wHyM5BbHgEGDIMYK4FbKINqlHhFAQEBA?=
 =?us-ascii?q?QEBBoEjgQ+UeDaEQAKCYiE4FAECAQEBAQEBAgFrKII1JAGCSQEFI0sLEAsOC?=
 =?us-ascii?q?gICJgICVwYBDAYCAQGCWIImDalhghyEWINlgi6BCYcDgQyBB4Eygjouh3OCN?=
 =?us-ascii?q?CACl3MIjjoGgTSDXYc9kVIzIYFSKwgCGAghDzuCQ4IgF44zIzBiAY9KAQE?=
Subject: Re: [PATCH 04/24] VFS: Add LSM hooks for filesystem context [ver #7]
To: David Howells <dhowells@redhat.com>, Paul Moore <paul@paul-moore.com>
Cc: viro@zeniv.linux.org.uk, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org,
        selinux@tycho.nsa.gov
References: <CAHC9VhQhaBNBFwAXJ4TxKO56UTcwb_LcT2G8LwNxdxOD96tTvA@mail.gmail.com>
 <152414466005.23902.12967974041384198114.stgit@warthog.procyon.org.uk>
 <152414469006.23902.8132059438921850399.stgit@warthog.procyon.org.uk>
 <3232.1524238511@warthog.procyon.org.uk>
From: Stephen Smalley <sds@tycho.nsa.gov>
Message-ID: <aca7e68c-022b-47ac-c249-59e042d431e8@tycho.nsa.gov>
Date: Mon, 23 Apr 2018 09:25:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <3232.1524238511@warthog.procyon.org.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/20/2018 11:35 AM, David Howells wrote:
> Paul Moore <paul@paul-moore.com> wrote:
> 
>> Adding the SELinux mailing list to the CC line; in the future please
>> include the SELinux mailing list on patches like this.  It would also
>> be very helpful to include "selinux" somewhere in the subject line
>> when the patch is predominately SELinux related (much like you did for
>> the other LSMs in this patchset).
> 
> I should probably evict the SELinux bits into their own patch since the point
> of this patch is the LSM hooks, not specifically SELinux's implementation
> thereof.
> 
>> I can't say I've digested all of this yet, but what SELinux testing
>> have you done with this patchset?
> 
> Using the fsopen()/fsmount() syscalls, these hooks will be made use of, say
> for NFS (which I haven't included in this list).  Even sys_mount() will make
> use of them a bit, so just booting the system does that.
> 
> Note that for SELinux these hooks don't change very much except how the
> parameters are handled.  It doesn't actually change the checks that are made -
> at least, not yet.  There are some additional syscalls under consideration
> (such as the ability to pick a live mounted filesystem into a context) that
> might require additional permits.

Neither fsopen() nor fscontext_fs_write() appear to perform any kind of up-front
permission checking (DAC or MAC), although some security hooks may be ultimately called
to allocate structures, parse security options, etc.  Is there a reason not apply a may_mount()
or similar check up front?
