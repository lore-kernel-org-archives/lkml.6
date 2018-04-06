Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755005AbeDFNxO (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 09:53:14 -0400
Received: from mx142.netapp.com ([216.240.21.19]:44900 "EHLO mx142.netapp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753139AbeDFNoP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 09:44:15 -0400
X-IronPort-AV: E=Sophos;i="5.48,415,1517904000";
   d="scan'208";a="246522074"
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Anna.Schumaker@netapp.com;
Subject: Re: linux-next: bad commits in the nfs-anna tree
To: Stephen Rothwell <sfr@canb.auug.org.au>,
        Trond Myklebust <trondmy@gmail.com>,
        NFS Mailing List <linux-nfs@vger.kernel.org>
CC: Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180406074314.7ae8652e@canb.auug.org.au>
From: Anna Schumaker <Anna.Schumaker@Netapp.com>
Message-ID: <f728fad9-bc15-b968-2965-d17c6893efc3@Netapp.com>
Date: Fri, 6 Apr 2018 09:44:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180406074314.7ae8652e@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [99.9.112.69]
X-ClientProxiedBy: DM5PR0401CA0045.namprd04.prod.outlook.com
 (2603:10b6:4:73::22) To DM5PR06MB3161.namprd06.prod.outlook.com
 (2603:10b6:4:41::20)
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d197be8-d916-4cef-802b-08d59bc47b7f
X-Microsoft-Antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4604075)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7193020);SRVR:DM5PR06MB3161;
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3161;3:siUwaUVAnj13upQ9vi+KtO0XM2dpUOIG5kW54dFFTyFOWtN5JrpzQBW7zS8Wq3D535oEjg6mRDzkBsoZ/PQx2vTsrmViKiyLsvL9CKHGRrqBsdI+WAsorTXwOmydeqx3tsNc9FEr9DfoaMzLZemZBTaOwCm0qo/pxkHVOvhimLay4zFRIo6G650w3hSj07uWw+dkwL/KXkWuNEeGaIzPWP8B+jBhyH8rKgRiLj7fYEumiwPEZrM3jssfIxonW/n+;25:16oJMYzLTjROj9vbp3Qx4hWo9Sv5B2n+U8jchFlc82IeBEmMWMi5k1DLRSU2u3znaO4bWanWNsnm2StEDzbn/o9ju4dRHQUBKd+1alucAil8718JljEm1vqnihpKBc4GPF4TkWbgNRVYvs333hVKqqhvPef7p8HM5eSgl00x73zDWzbl3qeh+CqbB5pNFQsfomUVUImgI7HkYRjSV7CvDXLvEoKDo7iYJXAWxMy7tI3vvb+CVLzoerY2qxHNvmP1osLL9M45syWGcqtINqcdYnVynHMhvVwu6PF79DfTe7+e15qn/BlFbdIgxn5UWs02flRagRe8hhHun+EgGyC+NQ==;31:1Yr0SLE4Hap06GC+1Sdj719MTJrdSMnBp0YX6emvvShURdYyJbNJZE8MrZSABpBir6slWYAM6uZb0y+WHNtmAKB4xYZurXvQaiZxaktOW/JmdlfCv89OelyloupR1rxkeipzbmHBBfKTMDWtFoP1HVt8hPTp2l8WUSaCqKE9cznDCZ2zJL+TB+3UtdiYJt0RUV/J9w8cUxIChH0Im9aPGlyPVb1k6/Ri5JKfBYUbR4I=
X-MS-TrafficTypeDiagnostic: DM5PR06MB3161:
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3161;20:SHKIpjHeFZo8Fh+nxnmw55xGgFdXydqObdKWIBlfoZ02TpTQP2LbAYxrNpfG4andVZTsgbHLvN72yEYrzt6Yes4C2XfRHqQ/5Y8shYvLem+AO1lYng7cQmSUwRW0oJDWY5axLjBiIITgHnYKpNb47oOwl6hdWT6pf6M+I/C2S37F5kXUY/aYHUXlae+So7vW2Ax/Ix3k8hHpKcUg6SqE51Zs2mZO5F251JQ3qtanIfbobSM2wr1Y2IsNNTWLmTuOM0SYNjZHj3BBCWwblY3Zg6Jueo0khMMOiMPsgQViU7Wb2qCUC0k3Q7rjHEZdrBBcbMR1B1UQZ76JLRnSJDU6fFQdLfhYISobXIKhy5a5YeVL4NBqfPHGcxY7g2przUH1wTiG6wNlikb9/PaWHh2W2pdPaoIMWvDEEoevbWHaN1PQntRbNUAFQTFGZbk9elgS8OsDEXKK3hL71VzrXCR3I6E2gLHIqInu5O6L7Sort/mD02CK0rmn40rKCigAZ5aO;4:W045fZtnzPjrb+Gr3r4rcENFyoTgJFxgKbA+sEOnKFqTGga+C2OQKP5QN9Gw0cFF/NRKaVhaJPSoPftO8Eq2ZP65semI6/yhxP2PkgG+h1R6mg4scVEJzqupbv12eBodwpoLpTTtPWxqfxQA49Dsdh/JVvwtlOaD/vuzh4NaqrwQHHyeJ/FdHxLC38pgASxl+mue2ahj1bmTAy69KqCmGg1WJlWuC/8CuB0rTtlEwKBq4nnxePcuCkKOb0BHdOMei/X0nM1TJEpCOHV/kmZsqw==
X-Microsoft-Antispam-PRVS: <DM5PR06MB316104103EA7D6B978446F9DF8BA0@DM5PR06MB3161.namprd06.prod.outlook.com>
X-Exchange-Antispam-Report-Test: UriScan:;
X-Exchange-Antispam-Report-CFA-Test: BCL:0;PCL:0;RULEID:(8211001083)(6040522)(2401047)(8121501046)(5005006)(3231221)(944501327)(52105095)(93006095)(93001095)(3002001)(10201501046)(6055026)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123562045)(6072148)(201708071742011);SRVR:DM5PR06MB3161;BCL:0;PCL:0;RULEID:;SRVR:DM5PR06MB3161;
X-Forefront-PRVS: 0634F37BFF
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10009020)(39380400002)(366004)(396003)(346002)(39860400002)(376002)(53754006)(189003)(199004)(58126008)(54906003)(105586002)(68736007)(110136005)(186003)(16526019)(229853002)(26005)(52116002)(8936002)(47776003)(6666003)(316002)(11346002)(72206003)(66066001)(446003)(65956001)(3846002)(6116002)(53416004)(65806001)(31686004)(2906002)(6246003)(64126003)(2616005)(956004)(575784001)(86362001)(53936002)(31696002)(36756003)(4326008)(69596002)(6512007)(97736004)(25786009)(50466002)(305945005)(106356001)(7736002)(53546011)(6506007)(81156014)(6486002)(230700001)(39060400002)(386003)(5660300001)(476003)(478600001)(65826007)(486006)(23746002)(76176011)(81166006)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR06MB3161;H:gouda.nowheycreamery.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
X-Microsoft-Exchange-Diagnostics: =?Windows-1252?Q?1;DM5PR06MB3161;23:eLDPE/fwPURykVFFyioWeLcrcgK+QN81Bw8A1?=
 =?Windows-1252?Q?nqff3T1Gn7bJ4MJznLb6GIc5dg1o027vEt84PuGFPrQLecu7Ir+nzLev?=
 =?Windows-1252?Q?7EezC2COWzjSflBNI6ZKGlsTKEPQckMmzGwS/Gc0mxoTn6K8Ak/uG9EJ?=
 =?Windows-1252?Q?w4yvVRzljF+TlJnOvqW5pgEzvzZFFz8NaFU1J/hg+TU8HQ7hqDSac31u?=
 =?Windows-1252?Q?SjfJtUEvYqvvI/z1smk3s59CKzg1T2BlneD06XGamM9V0K8hPPbzLXgs?=
 =?Windows-1252?Q?T6BO1x5NCaeqBJ7Y6woM30aWxVHbTFhPyIcXGn34pq2m+2U8oQZVYe3f?=
 =?Windows-1252?Q?pHKiwTXmj9FZKENXzVrbmvp2DrZlENBLIBs6De95FHaSMCoeV4sVCiOh?=
 =?Windows-1252?Q?kzODBNiJLNyoW476SJUgCzlh0BVIDsW2SjLR5aFPvYR32/ei3T0fA6tY?=
 =?Windows-1252?Q?UlsWtXA9oHjRNXXi737gPDI6GicJz78zSsUIkq414w18EXgZtoSgwzdI?=
 =?Windows-1252?Q?OMhX8/omU8DNbjMHT840lKRvI+araAtIzNMF87Zi0GnAth1BnnmGytjj?=
 =?Windows-1252?Q?qXJWc14iLTJdzU9jjYaTvvSftB8kkaA4P6mqosP4sON99Sye+E2u49HZ?=
 =?Windows-1252?Q?6yaNqEWJY9U5oQJHPnII8unDrsVIqghj3/eTG9GvBf9HSiRBtniSvjnt?=
 =?Windows-1252?Q?h+tVx0W/LfHyd6i3jSIy9MCD+c7Lya9ePuvC0BLwaS9L5ec8L9xte4ds?=
 =?Windows-1252?Q?TE4Gi0tcWUw9/6Hw8U309ykRL7alXpgV3OKu3ym9C0TGPPB23z6+SEng?=
 =?Windows-1252?Q?BQQSdGD6t6At1WmXmiesbeYfR65LpDx+innFwMpm5DIoN32l3+0qrWFT?=
 =?Windows-1252?Q?Cdg7qlB3vpzoVsGhSg2Bs6ORNbqdxc1YIimnWSDQ40MYaycF5YOXwd8+?=
 =?Windows-1252?Q?oT2cyMvJYYUoQkMrMostjz5bupBYI6jzMCSv86DC88J6m9uyprQYAFsc?=
 =?Windows-1252?Q?1Vje53Xrjk6AV+iGKmvbtZXrnu1zAt9sr1y4dSoxeI81RDRVucV+H29o?=
 =?Windows-1252?Q?sVrVsVJy0iITvnA7QGO7S2qrTZR1E5ymzdxmzIASKUKpMfeG0ocGhu7M?=
 =?Windows-1252?Q?5XMSoq1zhl7/1TxjiM+u2ByNJI0kKsR2iebw0sM4MHTHBKp2nMERbN6C?=
 =?Windows-1252?Q?5Xio3hjUri7QQDL7POvhFkz8OjYep3bkT06sRbxk7y/9bGCjYSEBirMH?=
 =?Windows-1252?Q?M1k8ybGNS05pfUjE1Pqxr/rE98KhzgLopgy7VkvO2mqgMH/YaxQrsf2l?=
 =?Windows-1252?Q?WRTK0NJWZa0Onfm4hYmnl5i2hB9748Uc/VkYG2+jSxM0QWmi6qDIjo8a?=
 =?Windows-1252?Q?linBGacT0UeSwny07MuQWE5ToY5pc5RJ4gzNP3UTxhtG8+kZzODqzP45?=
 =?Windows-1252?Q?xLLl6i2rp7fH3zCws2/pVCtieo2qaYR1bQ0OykyLiUDUeSKjJo/Ma9NN?=
 =?Windows-1252?Q?sn+VyR6dp0JPke0N851FluHi+d6r+xhI8PgeS3t/SD2xNisLrZgS+2cH?=
 =?Windows-1252?Q?AIH8WULExEthIH9UF8x3PLmyh0gi3Gc/DMZsT/ToTYqzGCckv9jHlXIm?=
 =?Windows-1252?Q?1hV1R7wgHWwsvCaOzDj8tk=3D?=
X-Microsoft-Antispam-Message-Info: IPHZcQAczUPHCWTeOs58EwWbz7lBTwjtsojpVi/t+A9iA4XEeBIuX2M6j7Ky/nbQ7flM+8bd6W4lDiq0+6uEC5wZzO8BtrHZH486n4h982+gIYRkVNQUEEmo8kDVYb/UE1r2k0J6aOnjYNhukjIj2tWSK/3PyL4DJS0amUdm6/Ehc9G9lDc6dxk/5zoyXA44
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3161;6:jBZmG3AEkUIEc02xDH/HcYeDWhJot68p4AwQZTbXpW8feuOoPHEXlOGMyQ+hdoc7iUanJY/xpoKgvtJkYbmUgOFekhlVfki1enDC5aLwVH3d0kf57iH8OhlUwhcgB+RenXj5oawapGCC4Rz6+EZR4Zpr1lDwFhj5zrc01mDRLYKdH8xP+k7yVIMtaTiVoG/8FY4n4rz4j1je9kMFV4Be0PRyZu5oGX+y8VdisfQEq34okJPXPtKkS+Be4CL6HEV+fciURhbXweOfLmi9aLCad0I/00P2wDyangrGCAZZ0HjT4rOk7D1ddWJV5Ta/f613KWlftlQu2BxuF6RhHhAZRxhIN1VRWyp/7PWOnwiwuIQG8VqGHAZP0ofA8F2On1BWCmaQmi58hCaS486g6x46xgEOLBJLej70uZkscOpwe8x6wHQ8+IfXmDTQGP/jECNbdlpgo/P4/Bvxs+AdDV1wFQ==;5:VllTdqVbflC+OUJ2VmDgKGMWDOUAaH9dICPYr+S9BJM44ifL1E/0COjOe3VTw60CLF0FSC41Xi+OGmiCf7yY0Kv1FZ4LtBoFtjW2SGKe/1ZTi4hSwI//VC7l2pivmBb7lOK8bIED5tj5nJXBgsz16E54Lrc8WBVJhbuFtK3qPbY=;24:JU2gQA1DBgBhZ+yzpLYSfHezEg2nqWNYecISbl7FYYqvEXj0s6K3N8tPEY2pfmZ73DNZWPbNYcaUb6r6OwJE6mX8rOoGyYSUT63DDEB4mmk=
SpamDiagnosticOutput: 1:99
SpamDiagnosticMetadata: NSPM
X-Microsoft-Exchange-Diagnostics: 1;DM5PR06MB3161;7:VZbNjjx+6N4gCByYZ/VWIizEo1Akjb3lT8MHxdAXGDUIh/bl3PyFXAMwH6MqCmmNZMFalALBdVlZNs8dI0Kxh3ohzD5FZSV7wWRD3+GRar+II/3yEW2EHsO9rR+7+PMnLjI9WQuktNb1ttVDgpOSZel67hPB/ecCnrnFOkmMWcAUAULQdTKFcxYhsLISORIiMrW53V9smyiGvSE6wg56gcMiBSX9FSIUenMmlR+g7Xd2vR8dE8iTHdODYl9Sb9pE
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2018 13:44:12.6358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d197be8-d916-4cef-802b-08d59bc47b7f
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4b0911a0-929b-4715-944b-c03745165b3a
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR06MB3161
X-OriginatorOrg: netapp.com
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/05/2018 05:43 PM, Stephen Rothwell wrote:
> Hi all,
> 
> It looks like part of Linus' tree has been rebased into the nfs-anna tree ... commits
> 
>   4c8936622a01 ("btrfs: use kvzalloc to allocate btrfs_fs_info")
> to
>   8f1cd0ae48f5 ("Linux 4.16-rc4")
> 
> in the nfs-anna tree are the same as commits
> 
>   a8fd1f717493 ("btrfs: use kvzalloc to allocate btrfs_fs_info")
> to
>   661e50bc8532 ("Linux 4.16-rc4")
> 
> I can't use the nfs-anna tree as it is, please fis it up.

Weird.  I removed a few patches from the middle of my tree after finding a bug, but I guess I gave my interactive rebase a slightly too wide range.  It should be fixed now.

Anna
> 
