Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933501AbeD1N7f (ORCPT <rfc822;w@1wt.eu>);
        Sat, 28 Apr 2018 09:59:35 -0400
Received: from mx2.suse.de ([195.135.220.15]:40248 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1759651AbeD1N7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Apr 2018 09:59:32 -0400
Subject: Re: copy_file_range and user space tools to do copy fastest
To: Steve French <smfrench@gmail.com>, Andreas Dilger <adilger@dilger.ca>
Cc: Eric Biggers <ebiggers3@gmail.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        CIFS <linux-cifs@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
References: <CAH2r5mtRF-yS6stThuVzem+WFmxDqpGLwFvUPviYcmh9dXXwkA@mail.gmail.com>
 <EFCB08E9-C9B9-41AC-A398-4D552FC8EFC9@dilger.ca>
 <20180427234126.GA213261@gmail.com>
 <736468DE-36BE-471B-B5F2-DB3D0B3E892B@dilger.ca>
 <CAH2r5mv7nxfgdr_rgk6oRLPN9UhXKDnU6n1PP9hu6r-X1E+iHg@mail.gmail.com>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
Openpgp: preference=signencrypt
Autocrypt: addr=rgoldwyn@suse.de; prefer-encrypt=mutual; keydata=
 xsDiBEaI9tIRBAC+jCQxwxm9mPCrzNiUskTzyLKUPLdW4n8Rjmt/N4ISt0AZWDKq7SpiDQjr
 yfOORLFFBFsfSH40OJlBjIpO+mh9XHPbc83bOESJdT5huIbC/0yuqR0xYVt+U0FLXQJ3w70N
 9eALGVxPPcQ3uIBpdTJUqkvKf9x3xLUdqRe/GQnXcwCgjKJ0sON51KlW36oNEyj4gF50Pg8D
 /jis+JcqnVlunIkGljWiYu6gNVXBXXiFqqbxnwWDGrA1e86Xl8A/aJn5tP/XELURNU7L1H1L
 f1g3K/usDaTkNsJ1HwmH378ctJTu7JYx/euCoz7MhKEJ2EgLC0Ob262cnk9JLAnpJOYPwIhA
 dgdtcdqASfln8gfP+6M+qFqOopfKA/9xLmyVSfxEoy4qdhlUC3GRFjZ5Ste2aOr9G0JXnWIg
 jccn/dT4sOb2lhKIKHiJmD4ns8Io01QPh/Cd6ecZ6Cx3InCQHyzMOVvZn0fdbO9/+348yRSl
 YOBXoViPxlUWGc/52eWohuleDhsrtn0aVX4d1zvhc5oswj6dKDDvDnnN580lR29sZHd5biBS
 b2RyaWd1ZXMgPHJnb2xkd3luQHN1c2UuY29tPsKVBBMRAgBVAhsjBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgAIZAQUJHC+BBRYhBO+WsixA7W+EivWnh0m5sHYwIjhsBQJamCrlEhhoa3A6
 Ly9wZ3AubWl0LmVkdQAKCRBJubB2MCI4bHt8AJwKjLlv73VEx6e63oQfUoOJKibHWwCfXIG1
 LHEVJbYPWAPKQ6Zk8ZCodXrOwU0ERoj26RAIAKKaKET9+fkkdP745IAQ17wrIzkpU/pAz90C
 fjJVhKngrb6PMFHyOPXlRAyJPCpp8Whl8P+KmAM7SZof4n8aLyrl+SVYFMe9RwYSshD7eNBD
 WmPNJd2qK8JJLUC8/ZRb5yw/bHfIRITogS9Tie5WJwHjMapizdQV8dyI+hSpYmWPDSOUaYCF
 T/nWaQP2NObZDFpBX3P8kP3LSTP+JW3Fz06CrJ03bAtm2CPDNI02sc5MHvRJXGNM2grvh+bK
 4V0sDrBeWr9sHy5ADoIx9PXGIfNH4NbSVBSGW3Oy8dmZnDfMgtAb9oY6HaGKZDj/F+AgxywB
 8oyvGfrJhfizIYROmycAAwUH/AtsttodDYydHeM9GFiZy0o/n4FAseYiMJKRI8fC2pYvrojt
 zbpQKXa64vQv2INtJHm8D1iGpzdrNkjL5jlqPKSUIkhwt9yUpOH3UQifwYOeKZUiv7vrapnW
 1gJb7RWhg4ske+qOa2FKvFVMsJ2quuu0qHOH0K8l7T8VqaW8FH4097c3TeSO17qRtwnNm+F7
 a+cXijMOaajZ9Xp4X04+wrEf7Rmvhc0zr96t3Z5QYx4ZwoyDfLefm5ORUe2CcRva7TnycB9P
 IxdGoVS2eIyepO+RMjvq5e6xjkpoiJ3cybQhsUt+pZd/KGSkZmhHpId3Y6zivOq7Lj+ELOtW
 dOTcV0TCTwQYEQIADwIbDAUCWVJ2GQUJHC+AsAAKCRBJubB2MCI4bC2IAJoDDDkaRi7G/lzz
 fUIV2179DCq38wCaAmivz68q3lkN6rF6vnh5DEGS74c=
Message-ID: <a5f51dba-0673-9ef7-6705-e9690f8e6f4e@suse.de>
Date: Sat, 28 Apr 2018 08:59:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <CAH2r5mv7nxfgdr_rgk6oRLPN9UhXKDnU6n1PP9hu6r-X1E+iHg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/28/2018 12:26 AM, Steve French wrote:
> On Sat, Apr 28, 2018 at 12:18 AM, Andreas Dilger <adilger@dilger.ca> wrote:
>> On Apr 27, 2018, at 5:41 PM, Eric Biggers <ebiggers3@gmail.com> wrote:
>>>
>>> On Fri, Apr 27, 2018 at 01:45:40PM -0600, Andreas Dilger wrote:
>>>> On Apr 27, 2018, at 12:25 PM, Steve French <smfrench@gmail.com> wrote:
>>>>>
>>>>> Are there any user space tools (other than our test tools and xfs_io
>>>>> etc.) that support copy_file_range?  Looks like at least cp and rsync
>>>>> and dd don't.  That syscall which now has been around a couple years,
>>>>> and was reminded about at the LSF/MM summit a few days ago, presumably
>>>>> is the 'best' way to copy a file fast since it tries all the
>>>>> mechanisms (reflink etc.) in order.
>>>>>
>>>>> Since copy_file_range syscall can be 100x or more faster for network
>>>>> file systems than the alternative, was surprised when I noticed that
>>>>> cp and rsync didn't support it.  It doesn't look like rsync even
>>>>> supports reflink either(although presumably if you call
>>>>> copy_file_range you don't have to worry about that), and reads/writes
>>>>> are 8K. See copy_file() in rsync/util.c
>>>>>
>>>>> In the cp command it looks like it can call the FICLONE IOCTL (see
>>>>> clone_file() in coreutils/src/copy.c) but doesn't call the expected
>>>>> "copy_file_range" syscall.
>>>>>
>>>>> In the dd command it doesn't call either - see dd_copy in corutils/src/dd.c
>>>>>
>>>>> Since it can be 100x or more faster in some cases to call
>>>>> copy_file_range than do reads/writes back and forth to do a copy
>>>>> (especially if network or clustered backend or cloud), what tools are
>>>>> the best to recommend?
>>>>>
>>>>> Would rsync or cp be likely to take patches to call the standard
>>>>> "copy_file_range" syscall
>>>>> (http://man7.org/linux/man-pages/man2/copy_file_range.2.html)?
>>>>> Presumably not if it has been two+ years ... but would be interested
>>>>> what copy tools to recommend to use instead.
>>>>
>>>> I would start with submitting a patch to coreutils, if you can figure
>>>> out that code enough to do so (I find it quite opaque).  Since it has
>>>> been in the kernel for a while already, it should be acceptable to the
>>>> upstream coreutils maintainers to use this interface.  Doubly so if you
>>>> include some benchmarks with CIFS/NFS clients avoiding network overhead
>>>> during the copy.
>>>>
>>>
>>> For cp (coreutils), apparently there was a concern that copy_file_range()
>>> expands holes; see the thread at
>>> https://lists.gnu.org/archive/html/bug-coreutils/2016-09/msg00020.html.
>>> Though, I'd think it could just be used on non-holes only.  And I don't think
>>> the size_t type of 'len' is a problem either, since it's the copy length, not
>>> the file size.  You just call it multiple times if the file is larger.
>>
>> I think cp is already using SEEK_HOLE/SEEK_DATA and/or FIEMAP to determine
>> the mapped and sparse segments of the file, so it should be practical to
>> use copy_file_range() in conjunction with these to copy only the allocated
>> parts of the file.
> 
> For the case where clone/reflink or copy_file_range is supported - is
> there any reason to
> not sent the request to copy the whole file? Presumably long
> timeout/errors might be a concern, but
> that could happen with ranges too.  In any case, if sent the whole
> file copy request,
> the server file system can figure out the  holes and copy more efficiently.
> 
> In the case where it is copying local to remote or remote to local -
> figuring out whether it is
> sparse and optimizing makes a lot of sense - but I didn't think cp did
> that (at least the
> sections of code I was looking at).

cp does check for sparse files and tries to recreate them depending on
--sparse=WHEN option. Check the make_holes variable in copy.c. However,
we could still use copy_file_range() when make_holes is false and close
on success. However, you would have to be careful to check if the return
value is positive and less than len and have to act accordingly.

-- 
Goldwyn
