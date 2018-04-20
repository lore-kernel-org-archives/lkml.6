Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754797AbeDTMP7 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 20 Apr 2018 08:15:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60328 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1754591AbeDTMPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Apr 2018 08:15:55 -0400
Subject: Re: [PATCH] KVM: s390: reset crypto attributes for all vcpus
From: Janosch Frank <frankja@linux.ibm.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com,
        pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rkrcmar@redhat.com
References: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <870459b4-228d-0be3-5dd3-48ab480b46de@linux.ibm.com>
Openpgp: preference=signencrypt
Autocrypt: addr=frankja@linux.ibm.com; prefer-encrypt=mutual; keydata=
 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
 lFM6NIuMAY1Y
Date: Fri, 20 Apr 2018 14:15:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <870459b4-228d-0be3-5dd3-48ab480b46de@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="3eMqAE81vonGJFht6nNny6RbI9K2v3NPb"
X-TM-AS-GCONF: 00
x-cbid: 18042012-0040-0000-0000-0000044FB282
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 18042012-0041-0000-0000-000020F40E85
Message-Id: <ac56c3e5-bbf5-5083-9988-eb8a337e0bb0@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-04-20_05:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1709140000
 definitions=main-1804200121
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3eMqAE81vonGJFht6nNny6RbI9K2v3NPb
Content-Type: multipart/mixed; boundary="nTdTieXVKijukp1sK58IHlWQMAQqhisVQ";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com,
 pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rkrcmar@redhat.com
Message-ID: <ac56c3e5-bbf5-5083-9988-eb8a337e0bb0@linux.ibm.com>
Subject: Re: [PATCH] KVM: s390: reset crypto attributes for all vcpus
References: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <870459b4-228d-0be3-5dd3-48ab480b46de@linux.ibm.com>
In-Reply-To: <870459b4-228d-0be3-5dd3-48ab480b46de@linux.ibm.com>

--nTdTieXVKijukp1sK58IHlWQMAQqhisVQ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 20.04.2018 13:59, Janosch Frank wrote:
> Thanks, applied.
>=20

Well this does not compile, as you use kvm_s390_vcpu_crypto_setup before
declaration. Please fix, then I'll take the patch.


>=20
> On 19.04.2018 23:13, Tony Krowiak wrote:
>> Introduces a new function to reset the crypto attributes for all
>> vcpus whether they are running or not. Each vcpu in KVM will
>> be removed from SIE prior to resetting the crypto attributes in its
>> SIE state description. After all vcpus have had their crypto attribute=
s
>> reset the vcpus will be restored to SIE.
>>
>> This function is incorporated into the kvm_s390_vm_set_crypto(kvm)
>> function to fix a reported issue whereby the crypto key wrapping
>> attributes could potentially get out of synch for running vcpus.
>>
>> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c |   18 ++++++++++++++----
>>  arch/s390/kvm/kvm-s390.h |   13 +++++++++++++
>>  2 files changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index fa355a6..4fa3037 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -789,6 +789,19 @@ static int kvm_s390_set_mem_control(struct kvm *k=
vm, struct kvm_device_attr *att
>>  	return ret;
>>  }
>>
>> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
>> + {
>> +	int i;
>> +	struct kvm_vcpu *vcpu;
>> +
>> +	kvm_s390_vcpu_block_all(kvm);
>> +
>> +	kvm_for_each_vcpu(i, vcpu, kvm)
>> +	        kvm_s390_vcpu_crypto_setup(vcpu);
>> +
>> +	kvm_s390_vcpu_unblock_all(kvm);
>> +}
>> +
>>  static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
>>
>>  static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_=
attr *attr)
>> @@ -832,10 +845,7 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm=
, struct kvm_device_attr *attr)
>>  		return -ENXIO;
>>  	}
>>
>> -	kvm_for_each_vcpu(i, vcpu, kvm) {
>> -		kvm_s390_vcpu_crypto_setup(vcpu);
>> -		exit_sie(vcpu);
>> -	}
>> +	kvm_s390_vcpu_crypto_reset_all(kvm);
>>  	mutex_unlock(&kvm->lock);
>>  	return 0;
>>  }
>> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
>> index 1b5621f..981e3ba 100644
>> --- a/arch/s390/kvm/kvm-s390.h
>> +++ b/arch/s390/kvm/kvm-s390.h
>> @@ -410,4 +410,17 @@ static inline int kvm_s390_use_sca_entries(void)
>>  }
>>  void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
>>  				     struct mcck_volatile_info *mcck_info);
>> +
>> +/**
>> + * kvm_s390_vcpu_crypto_reset_all
>> + *
>> + * Reset the crypto attributes for each vcpu. This can be done while =
the vcpus
>> + * are running as each vcpu will be removed from SIE before resetting=
 the crypt
>> + * attributes and restored to SIE afterward.
>> + *
>> + * Note: The kvm->lock must be held while calling this function
>> + *
>> + * @kvm: the KVM guest
>> + */
>> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm);
>>  #endif
>>
>=20
>=20



--nTdTieXVKijukp1sK58IHlWQMAQqhisVQ--

--3eMqAE81vonGJFht6nNny6RbI9K2v3NPb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJa2dnzAAoJEBcO/8Q8ZEV5eLgP/2VWIvPhb9PlLBNNLTiZw9M6
IGScDIjRkHSwZA6YDeA+yaeQWJEFJnpt6NIa29d4O70tdGRV2zgPRIz2PdXeB0CR
8GaWmGipc7CbyS/lCKcatCssJqCpnaS+oc1+t/Lub2W7Dy1nvGNMXkXzVBx7wb/5
VDbZINzAkMdi8PIg1Zo5LvkkzotBkbQKYz0ywgmKVNo4ZD9AbQgDF3srf3YOkNGm
TzEuockYbgEia/p4bzRtRdt5vWCsFEMtoA/r3ZxRZn/6YfoqiuapNAwymH67DSvg
8sK2qqxzyZthGAbuY2xBDBVFIHB3nxiHpE1J3zsdICIIlDgif9yr9b56KNszn2vk
wJ//rMhDI+Y7az00CMxAoQv1gFQnpkkDa0eGor24dqkzvITXMmbBR4fFwWRuVHkA
oyzlGfUvOJsmFNwwYaJKahzLzyOwBkoY1DR5rZldn5niJPi2MmABvg4XGIoq+ZSC
hFTH0P4GNRDY8IX6lZ1LsxSDkjFFed+W2PBLqLdnJ4IeHs+JWpS5ydXcv3L5hEvo
kOEQJp4mKgXTBk+S71zRMFymCZOd/O5WuvyybYgl1npMp2+x9h4Geazanhq474uk
OWoIuXylKbh/0myav+NcPOhmpyak03+4pEmLeyMi+im/tjmdmqWIkY5LdApbRrb1
FbvAxj9Ee4bvgqnS7jxE
=97Ch
-----END PGP SIGNATURE-----

--3eMqAE81vonGJFht6nNny6RbI9K2v3NPb--
